### Entry Format

An entry (`<entry>`, RFC 4287 §4.1.2) is the unit of syndication —
one entry per syndicated artefact set (e.g. one RF2 package, one
FHIR CodeSystem, one FHIR NPM package).

Structural model:
[SyndicationEntry](StructureDefinition-syndication-entry.html).

### Atom core elements

Most elements in an entry describe the **artefact** the entry points to
(`<title>`, `<summary>`, `<rights>`, `<published>`, `<author>`,
`<category>`, `<link>`, and the [NCTS ASF metadata](#required-ncts-asf-metadata)
below). Only `<id>` and `<updated>` describe the **entry itself**. In
particular, `<id>` is the identity of the *entry*, which is distinct from the
identity of the *artefact* — that is carried by
`<ncts:contentItemIdentifier>` / `<ncts:contentItemVersion>`.

| Element | Card | Meaning / Constraint |
|---------|------|----------------------|
| `<id>` | 1..1 | Stable, globally-unique identifier **of this feed entry** (not of the artefact — see `<ncts:contentItemIdentifier>` below). Conventionally `urn:uuid:<uuid>`. **MUST NOT** change when the entry is updated. |
| `<title>` | 1..1 | Human-readable name of the artefact. |
| `<summary>` | 0..1 | Short description. |
| `<rights>` | 0..1 | Copyright / licence statement applicable to the artefact. |
| `<published>` | 0..1 | The instant the artefact set was first issued by its publisher. See FHIR alignment below. |
| `<updated>` | 1..1 | The instant this entry last changed in a way the publisher considers significant ([RFC 4287 §4.2.15](https://www.rfc-editor.org/rfc/rfc4287#section-4.2.15)) — e.g. a new version, corrected metadata, or a re-validated artefact. See note below. |
| `<author>` | 0..* | The party that produced the artefact. |
| `<category>` | 1..* | Classifies the artefact. At least one MUST be present; at least one SHOULD use a registered scheme. See [Category Schemes](categories.html). |
| `<link>` | 1..* | At least one. The primary artefact uses `rel="alternate"`; ancillary documents use `rel="related"`. See [SyndicationLink](StructureDefinition-syndication-link.html). |

`<updated>` is really a publisher-significant timestamp, not just a mechanical last-touched one.
A publisher MAY derive it from a FHIR resource's `meta.lastUpdated`, and doing so is not wrong — but it may be sub-optimal.
Bumping `<updated>` when nothing meaningful changed may create spurious re-processing, but the server itself may not be able to decide this on its own.

### Required NCTS ASF metadata

Every entry MUST include the `<ncts:contentItemIdentifier>` and
`<ncts:contentItemVersion>` elements. They are the fundamental keys
that consumers use to identify and version artefacts.

| Element | Meaning |
|---------|---------|
| `<ncts:contentItemIdentifier>` | Canonical, version-independent identifier. Stable across versions of the same logical artefact. |
| `<ncts:contentItemVersion>` | Canonical, version-specific identifier for this exact release. |

`<ncts:contentItemVersion>` MUST be unique within a feed — two entries
with the same value are duplicates.

### FHIR alignment

When an entry's artefact is a FHIR canonical resource (CodeSystem,
ValueSet, ConceptMap, NamingSystem, StructureDefinition, …) the
following alignments hold:

| Atom field | FHIR resource field |
|------------|---------------------|
| `<ncts:contentItemIdentifier>` | `Resource.url` |
| `<ncts:contentItemVersion>` | `Resource.url` + `\|` + `Resource.version` |
| `<published>` | `Resource.date` |
| `<title>` | `Resource.title` (else `Resource.name`) |
| `<rights>` | `Resource.copyright` |
| `<ncts:fhirVersion>` | The FHIR version the resource is authored against |
| `<ncts:fhirProfile>` | `Resource.meta.profile[*]` |

### SNOMED CT alignment

When an entry's artefact is a SNOMED CT module:

| Atom field | SNOMED CT mapping |
|------------|-------------------|
| `<ncts:contentItemIdentifier>` | `http://snomed.info/(x)?sct/<moduleId>` (unversioned module URI) |
| `<ncts:contentItemVersion>` | `http://snomed.info/(x)?sct/<moduleId>/version/<YYYYMMDD>` (versioned module URI) |

For a SNOMED CT extension or derivative, dependencies on other
SNOMED packages are declared via `<sct:packageDependency>` — see
[SNOMED CT Extensions](sct-extensions.html).

### Retraction entries

An entry whose category in the NCTS ASF scheme is one of the
`*_RETRACT` terms is a **retraction**: a directive that consumers
SHOULD un-load (or otherwise mark as withdrawn) the artefact
identified by `(contentItemIdentifier, contentItemVersion)`.

Field-by-field rules:

| Field | Retract-entry rule |
|-------|--------------------|
| `<category>` | At least one category MUST use a `*_RETRACT` term in the NCTS ASF scheme. |
| `<ncts:contentItemIdentifier>` | Required. Identifies *what* is retracted. |
| `<ncts:contentItemVersion>` | Required. Identifies *which version* — exactly. There is no blanket-retract semantics: to retract several versions, issue several entries. |
| `<ncts:fhirVersion>` | Required for any `FHIR_*_RETRACT`. |
| `<link rel="alternate">` | **MUST NOT be present.** A retract has nothing to download. |
| `<link rel="related">` | Permitted (e.g. a deprecation notice PDF). |
| `<link>` overall | MAY be absent entirely. |
| `<sct:packageDependency>` | SHOULD be absent. |
| `<ncts:bundleInterpretation>` | SHOULD be absent. |
| `<ncts:fhirProfile>` | SHOULD be absent. |
| `<published>` | SHOULD be the time the retraction was issued. |
| `<updated>` | As normal. |

A consumer that has never installed the named `<ncts:contentItemVersion>`
MUST silently no-op — there is no requirement that the retract
entry's keys match any previously-published non-retract entry.

A worked retract example is in [Examples](examples.html#a-retract-entry).

### Worked example

```xml
<entry>
  <title>SNOMED CT International Edition - April 2023 (RF2 Full)</title>
  <id>urn:uuid:3cca1feb-16f8-4c34-b5e4-692e70ae30ca</id>
  <updated>2023-09-20T14:02:22Z</updated>
  <published>2023-04-28T00:00:00Z</published>
  <summary>SNOMED International April 2023 SNOMED CT International Edition release package</summary>
  <author>
    <name>SNOMED International</name>
    <uri>https://www.snomed.org</uri>
    <email>info@snomed.org</email>
  </author>
  <category term="SCT_RF2_FULL" label="SNOMED CT RF2 Full"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <link rel="alternate" type="application/zip"
        href="https://mlds.ihtsdotools.org/api/.../download"
        length="533422481"
        sct:md5Hash="0290ad7f6e431063166afd91cd2b8c37"/>
  <ncts:contentItemIdentifier>http://snomed.info/sct/900000000000207008</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://snomed.info/sct/900000000000207008/version/20230430</ncts:contentItemVersion>
</entry>
```
