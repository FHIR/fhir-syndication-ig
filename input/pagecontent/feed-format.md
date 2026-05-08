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

### Content negotiation

The MIME type for an Atom feed document is `application/atom+xml`.
