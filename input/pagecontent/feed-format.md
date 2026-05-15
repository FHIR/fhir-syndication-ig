### Feed Format

A syndication feed is an Atom 1.0 document
([RFC 4287](https://www.rfc-editor.org/rfc/rfc4287)). The default
namespace is `http://www.w3.org/2005/Atom`. The structural model is
captured by the [SyndicationFeed](StructureDefinition-syndication-feed.html)
logical model.

### Required namespaces

```xml
xmlns="http://www.w3.org/2005/Atom"
xmlns:ncts="http://ns.electronichealth.net.au/ncts/syndication/asf/extensions/1.0.0"
xmlns:sct="http://snomed.info/syndication/sct-extension/1.0.0"
```

The `sct:` namespace is only required if any entry uses SNOMED CT
extension elements. The `onto:` namespace
(`http://ontoserver.csiro.au/syndication/`) is only required if any
entry uses the per-entry permission or per-link validation
extensions.

### Feed-level elements

| Element | Card | Meaning / Constraint |
|---------|------|----------------------|
| `<id>` | 1..1 | Stable, globally-unique identifier for the feed. Conventionally `urn:uuid:<uuid>`. **MUST NOT** change across re-publications of the same logical feed (RFC 4287 §4.2.6). |
| `<title>` | 1..1 | Human-readable feed name. |
| `<subtitle>` | 0..1 | Human-readable description. |
| `<updated>` | 1..1 | RFC 3339 timestamp. **SHOULD** equal the maximum `<updated>` of any entry currently in the feed. |
| `<generator>` | 0..1 | Identifies the publishing software. |
| `<link rel="self">` | 0..1 | Canonical URL of the feed. `type` is `application/atom+xml`. |
| `<ncts:atomSyndicationFormatProfile>` | 0..1 | ASF profile URI. **MUST** be present whenever any NCTS ASF extension element is used in the feed. Current value: `http://ns.electronichealth.net.au/ncts/syndication/asf/profile/1.0.0`. |
| `<entry>` | 0..* | Zero or more entries. Order is publisher-defined; consumers **MUST NOT** rely on order to determine recency — use entry-level `<updated>`. |

### Pagination

The format does not define a pagination scheme — a feed is a single
document. Publishers handling very large catalogues typically split
content across multiple feeds and use `<link rel="related">` to
reference them; this is out of scope for this specification.

### Feed filtering

Servers **SHOULD** support the query-string parameters below, applied
to the `<entry>` set before serialisation. Consumers **MAY** also
apply the same predicates client-side after retrieval — defensively
(a server that does not implement filtering will typically ignore
unknown parameters and return the full feed, indistinguishable from a
server that honoured them) or because the feed is served as a static
file. The semantics below are normative; whether the server, the
client, or both apply them is not.

| Parameter | Repeatable | Match rule |
|-----------|------------|------------|
| `canonical` | yes | Value is a FHIR [Canonical](https://www.hl7.org/fhir/datatypes.html#canonical) — `url` or `url\|version`. Matches an entry whose `ncts:contentItemIdentifier` equals the `url` part. If a `\|version` is supplied, `ncts:contentItemVersion` **MUST** also equal the version part. |
| `category` | yes | Matches an entry that has a `<category>` whose `term` attribute equals the value. Match is against `term` only — not `label`, not `scheme`. |
| `fhirVersion` | yes | Matches an entry whose `ncts:fhirVersion` equals the value, compared as `major.minor` (e.g. `4.0`). Publishers **SHOULD** emit `ncts:fhirVersion` in `major.minor` form; consumers **MUST** truncate to `major.minor` before comparing. |

When a parameter appears more than once, an entry matches if it
matches **any** of its values (OR). When different parameters are
present, an entry matches only if it matches **each** parameter
(AND). An entry that lacks the field a parameter is keyed on does
not match that parameter.

[Ontoserver](https://ontoserver.csiro.au/docs/) implements these
filters both as a server (applying them to its own published feed)
and as a client (re-applying them after retrieval, so the filter is
honoured even when the upstream feed does not support it).

### Content negotiation

The MIME type for an Atom feed document is `application/atom+xml`.
