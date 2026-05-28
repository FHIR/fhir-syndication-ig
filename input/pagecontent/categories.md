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
| `FHIR_ConceptMap` | FHIR ConceptMap | A single FHIR ConceptMap resource. |
| `FHIR_StructureDefinition` | FHIR StructureDefinition | A single FHIR StructureDefinition resource. |
| `FHIR_Bundle` | FHIR Bundle | A FHIR Bundle resource. The entry's `bundleInterpretation` element, when present, hints at the publisher's view of the Bundle (`batch` or `collection`). |
| `FHIR_Package` | FHIR Package | A FHIR NPM (`tgz`) package. |
| `LOINC` | LOINC | A LOINC release artefact. |
| `BINARY_RETRACT` | Binary Index Retract | Retracts a previously-published Ontoserver RF2 binary index. See [Retraction](#retraction). |
| `LOINC_RETRACT` | LOINC Retract | Retracts a previously-published LOINC artefact. |
| `FHIR_CodeSystem_RETRACT` | FHIR CodeSystem Retract | Retracts a previously-published FHIR CodeSystem. |
| `FHIR_ValueSet_RETRACT` | FHIR ValueSet Retract | Retracts a previously-published FHIR ValueSet. |
| `FHIR_ConceptMap_RETRACT` | FHIR ConceptMap Retract | Retracts a previously-published FHIR ConceptMap. |
| `FHIR_StructureDefinition_RETRACT` | FHIR StructureDefinition Retract | Retracts a previously-published FHIR StructureDefinition. |

### Ontoserver RF2 binary index scheme

A second scheme is used for entries publishing a **pre-built
Ontoserver RF2 binary index** — a zip containing the on-disk index
Ontoserver derives from a SNOMED CT RF2 release, ready to be loaded
directly without re-indexing. This is *not* a SNOMED CT release in
RF2 form; it is an Ontoserver-specific index file.

The scheme URI is versioned by **binary index format**, not by the
SNOMED CT release version it indexes:

- `http://ontoserver.csiro.au/syndication/rf2/1.0.0`
- `http://ontoserver.csiro.au/syndication/rf2/2.0.0`

A consumer MUST match the scheme URI exactly. Indexes from the
`1.0.0` and `2.0.0` schemes are not interchangeable. Consumers that
do not recognise either scheme MUST ignore the entry.

The single term used in this scheme is `BINARY`, conventionally
labelled `Binary Index`. See
[OntoserverRf2Index](CodeSystem-ontoserver-rf2-index.html).

```xml
<category term="BINARY" label="Binary Index"
          scheme="http://ontoserver.csiro.au/syndication/rf2/2.0.0"/>
```

The accompanying entry's `<ncts:contentItemIdentifier>` and
`<ncts:contentItemVersion>` SHOULD identify the underlying SNOMED CT
module and version that the index represents (i.e. the *content*),
exactly as for an RF2 release entry. The binary-index-format
version is carried by the scheme URI, separately from the content
version.

### Multiple categories

An entry MAY carry additional categories from other schemes — for
example, jurisdiction tags, edition tags, or publisher-internal
classifications. Consumers SHOULD ignore categories whose `scheme`
they do not recognise.

### Retraction

Six terms in the NCTS ASF scheme — collectively the `*_RETRACT`
terms — mark an entry as a **retraction** of a previously-published
artefact:

- `BINARY_RETRACT`
- `LOINC_RETRACT`
- `FHIR_CodeSystem_RETRACT`
- `FHIR_ConceptMap_RETRACT`
- `FHIR_ValueSet_RETRACT`
- `FHIR_StructureDefinition_RETRACT`

Semantics:

- A retract entry targets the **exact** `contentItemVersion` named
  in the entry. Retraction is not blanket: a publisher wishing to
  withdraw multiple versions of the same `contentItemIdentifier`
  MUST issue one retract entry per version.
- A retract entry is a unilateral assertion. It does **not** require
  a matching previously-published non-retract entry in the same
  feed. A consumer that never installed the named
  `contentItemVersion` MUST silently no-op.
- A retract entry MUST NOT carry any `<link rel="alternate">` —
  there is nothing to download. It MAY carry `<link rel="related">`
  links (e.g. a deprecation notice).
- For `FHIR_*_RETRACT`, the `<ncts:fhirVersion>` rule still applies:
  the entry MUST carry `<ncts:fhirVersion>`.
- `<sct:packageDependency>` and `<ncts:bundleInterpretation>` SHOULD be
  absent on retract entries.

Note: `BINARY_RETRACT` lives in the **NCTS ASF** scheme, even
though the corresponding non-retract `BINARY` term lives in the
[Ontoserver RF2 binary index scheme](#ontoserver-rf2-binary-index-scheme).

See [Retraction entries](entry-format.html#retraction-entries) for
the field-by-field rules.

### Constraints

When the NCTS ASF category term is `FHIR_CodeSystem`,
`FHIR_ValueSet`, `FHIR_ConceptMap`, `FHIR_StructureDefinition`,
`FHIR_Bundle`, `FHIR_Package`, or any `FHIR_*_RETRACT`
counterpart, the entry MUST also carry `<ncts:fhirVersion>`.
