### Terminology Syndication Feed

This Implementation Guide specifies the **Atom-based terminology
syndication feed format** — the wire format used to publish lists of
terminology releases (SNOMED CT RF2 packages, FHIR CodeSystems,
ValueSets, Bundles, NPM packages, LOINC distributions, and other
terminology artefacts) so that downstream terminology servers can
discover and consume them.

The format is **Atom 1.0** ([RFC 4287](https://www.rfc-editor.org/rfc/rfc4287))
extended with three namespaces:

| Prefix | Namespace URI | Purpose |
|--------|---------------|---------|
| `ncts` | `http://ns.electronichealth.net.au/ncts/syndication/asf/extensions/1.0.0` | Terminology metadata: canonical identifier, version, FHIR version, FHIR profile, bundle interpretation, SHA-256 hash, ASF profile declaration |
| `sct`  | `http://snomed.info/syndication/sct-extension/1.0.0` | SNOMED CT package dependencies and MD5 hashes |
| `onto` | `http://ontoserver.csiro.au/syndication/` | Per-entry permissions and per-link validation state |

Together these are referred to as the **NCTS Atom Syndication Format
(ASF) profile**, currently at version `1.0.0`. Feeds that conform to
this profile declare it via the `ncts:atomSyndicationFormatProfile`
element on the feed:

```xml
<ncts:atomSyndicationFormatProfile>
  http://ns.electronichealth.net.au/ncts/syndication/asf/profile/1.0.0
</ncts:atomSyndicationFormatProfile>
```

### Scope

This guide describes:

- The **shape** of feeds, entries, links, and categories.
- The **meaning** of each field and each extension element.
- The **constraints** that hold across fields — including alignment
  with FHIR canonical resource metadata.
- The **controlled vocabularies** used in `<category>`.

It does not describe any specific publishing or consuming software.

### Reading guide

- [Feed Format](feed-format.html) — feed-level elements
- [Entry Format](entry-format.html) — entry-level elements and
  cross-field constraints
- [Category Schemes](categories.html) — the NCTS ASF scheme and the
  full set of content-type terms
- [NCTS ASF Extensions](ncts-extensions.html),
  [SNOMED CT Extensions](sct-extensions.html),
  [Ontoserver Extensions](onto-extensions.html) — element-by-element
  reference for each extension namespace
- [Security](security.html) — the per-entry permission mechanism
- [Examples](examples.html) — annotated real-world feed fragments
