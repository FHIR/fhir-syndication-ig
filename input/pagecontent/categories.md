### Category Schemes

Each `<entry>` carries one or more `<category>` elements that
classify the artefact:

```xml
<category term="SCT_RF2_FULL"
          label="SNOMED CT RF2 Full"
          scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
```

| Attribute | Cardinality | Meaning |
|-----------|-------------|---------|
| `term` | 1..1 | Machine-readable code from the scheme. |
| `scheme` | 1..1 | URI identifying the controlled vocabulary the term comes from. |
| `label` | 0..1 | Human-readable form. |

### NCTS ASF scheme

**Scheme URI:** `http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0`

This is the primary classification scheme. At least one category
on each entry SHOULD use this scheme so consumers can determine
the artefact type without inspecting the artefact itself.

The full set of terms is defined as a CodeSystem in this guide:
[SyndicationContentType](CodeSystem-syndication-content-type.html).

| Term | Label | Meaning |
|------|-------|---------|
| `SCT_RF2_ALL` | SNOMED CT RF2 All | RF2 release package containing both Snapshot and Full release types. |
| `SCT_RF2_FULL` | SNOMED CT RF2 Full | RF2 release package containing the Full release type only. |
| `SCT_RF2_SNAPSHOT` | SNOMED CT RF2 Snapshot | RF2 release package containing the Snapshot release type only. |
| `SCT_RF2_DELTA` | SNOMED CT RF2 Delta | RF2 release package containing the Delta release type only. |
| `FHIR_CodeSystem` | FHIR CodeSystem | A single FHIR CodeSystem resource. |
| `FHIR_ValueSet` | FHIR ValueSet | A single FHIR ValueSet resource. |
| `FHIR_Bundle` | FHIR Bundle | A FHIR Bundle resource. The entry's `bundleInterpretation` element specifies `batch` or `collection`. |
| `FHIR_Package` | FHIR Package | A FHIR NPM (`tgz`) package. |
| `LOINC` | LOINC | A LOINC release artefact. |
| `BINARY` | Binary | An opaque binary artefact. Consumers MUST use the link's `type` attribute to determine media type. |

### Multiple categories

An entry MAY carry additional categories from other schemes — for
example, jurisdiction tags, edition tags, or publisher-internal
classifications. Consumers SHOULD ignore categories whose `scheme`
they do not recognise.

### Constraints

When the NCTS ASF category term is `FHIR_CodeSystem`,
`FHIR_ValueSet`, `FHIR_Bundle`, or `FHIR_Package`, the entry MUST
also carry `ncts:fhirVersion`.
