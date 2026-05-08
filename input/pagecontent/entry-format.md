### Entry Format

An entry (`<entry>`, RFC 4287 §4.1.2) is the unit of syndication —
one entry per syndicated artefact set (e.g. one RF2 package, one
FHIR CodeSystem, one FHIR NPM package).

Structural model:
[SyndicationEntry](StructureDefinition-syndication-entry.html).

### Atom core elements

| Element | Card | Meaning / Constraint |
|---------|------|----------------------|
| `<id>` | 1..1 | Stable, globally-unique identifier. Conventionally `urn:uuid:<uuid>`. **MUST NOT** change when the entry is updated. |
| `<title>` | 1..1 | Human-readable name of the artefact. |
| `<summary>` | 0..1 | Short description. |
| `<rights>` | 0..1 | Copyright / licence statement applicable to the artefact. |
| `<published>` | 0..1 | The instant the artefact set was first issued by its publisher. See FHIR alignment below. |
| `<updated>` | 1..1 | The instant this entry's metadata or artefacts last meaningfully changed. |
| `<author>` | 0..* | The party that produced the artefact. |
| `<category>` | 1..* | Classifies the artefact. At least one MUST be present; at least one SHOULD use a registered scheme. See [Category Schemes](categories.html). |
| `<link>` | 1..* | At least one. The primary artefact uses `rel="alternate"`; ancillary documents use `rel="related"`. See [SyndicationLink](StructureDefinition-syndication-link.html). |

### Required NCTS ASF metadata

Every entry MUST include the `ncts:contentItemIdentifier` and
`ncts:contentItemVersion` elements. They are the fundamental keys
that consumers use to identify and version artefacts.

| Element | Meaning |
|---------|---------|
| `ncts:contentItemIdentifier` | Canonical, version-independent identifier. Stable across versions of the same logical artefact. |
| `ncts:contentItemVersion` | Canonical, version-specific identifier for this exact release. |

`ncts:contentItemVersion` MUST be unique within a feed — two entries
with the same value are duplicates.

### FHIR alignment

When an entry's artefact is a FHIR canonical resource (CodeSystem,
ValueSet, ConceptMap, NamingSystem, StructureDefinition, …) the
following alignments hold:

| Atom field | FHIR resource field |
|------------|---------------------|
| `ncts:contentItemIdentifier` | `Resource.url` |
| `ncts:contentItemVersion` | `Resource.url` + `\|` + `Resource.version` |
| `<published>` | `Resource.date` |
| `<title>` | `Resource.title` (else `Resource.name`) |
| `<rights>` | `Resource.copyright` |
| `ncts:fhirVersion` | The FHIR version the resource is authored against |
| `ncts:fhirProfile` | `Resource.meta.profile[*]` |

### SNOMED CT alignment

When an entry's artefact is a SNOMED CT module:

| Atom field | SNOMED CT mapping |
|------------|-------------------|
| `ncts:contentItemIdentifier` | `http://snomed.info/sct/<moduleId>` (unversioned module URI) |
| `ncts:contentItemVersion` | `http://snomed.info/sct/<moduleId>/version/<YYYYMMDD>` (versioned module URI) |

For a SNOMED CT extension or derivative, dependencies on other
SNOMED packages are declared via `sct:packageDependency` — see
[SNOMED CT Extensions](sct-extensions.html).

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
