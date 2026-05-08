CodeSystem: SyndicationContentType
Id: syndication-content-type
Title: "Terminology Syndication Content Type"
Description: """
The set of terms used in `<category term=\"…\">` to identify what
kind of terminology artefact a syndication entry carries.

This code system represents the NCTS Atom Syndication Format
category scheme, identified by the URI
`http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0`.

Every entry SHOULD include at least one category whose `scheme` is
this URI; consumers use this category to decide how to load the
linked artefact.
"""
* ^url = "http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"
* ^caseSensitive = true
* ^content = #complete
* ^experimental = false
* ^hierarchyMeaning = #grouped-by

// ── SNOMED CT RF2 packages ────────────────────────────────────────────────
* #SCT_RF2_ALL "SNOMED CT RF2 All" "An RF2 release package containing both the Snapshot and Full release types."
* #SCT_RF2_FULL "SNOMED CT RF2 Full" "An RF2 release package containing the Full release type only — every component version since the module's first release."
* #SCT_RF2_SNAPSHOT "SNOMED CT RF2 Snapshot" "An RF2 release package containing the Snapshot release type only — the current state of every component as at the release date."
* #SCT_RF2_DELTA "SNOMED CT RF2 Delta" "An RF2 release package containing the Delta release type only — components changed since the previous release."

// ── FHIR resources ────────────────────────────────────────────────────────
* #FHIR_CodeSystem "FHIR CodeSystem" "A single FHIR CodeSystem resource."
* #FHIR_ValueSet "FHIR ValueSet" "A single FHIR ValueSet resource."
* #FHIR_ConceptMap "FHIR ConceptMap" "A single FHIR ConceptMap resource."
* #FHIR_StructureDefinition "FHIR StructureDefinition" "A single FHIR StructureDefinition resource."
* #FHIR_Bundle "FHIR Bundle" "A FHIR Bundle resource. The entry's `bundleInterpretation` element, when present, hints at the publisher's view of the Bundle (`batch` or `collection`); the consumer is not obliged to follow the hint."
* #FHIR_Package "FHIR Package" "A FHIR NPM (`tgz`) implementation guide / package."

// ── Other terminologies ───────────────────────────────────────────────────
* #LOINC "LOINC" "A LOINC release artefact."

// ── Retractions ───────────────────────────────────────────────────────────
// A retract entry asserts that the artefact identified by
// (contentItemIdentifier, contentItemVersion) is withdrawn. Targets the
// exact contentItemVersion named — there is no blanket-retract semantics.
// A consumer that never installed that version MUST silently no-op.
// Retract entries MUST NOT carry a <link rel="alternate"> (there is
// nothing to download); they MAY carry <link rel="related"> for
// deprecation notices.
* #BINARY_RETRACT "Binary Index Retract" "Retraction of a previously-published Ontoserver RF2 binary index identified by the entry's contentItemIdentifier and contentItemVersion."
* #LOINC_RETRACT "LOINC Retract" "Retraction of a previously-published LOINC artefact."
* #FHIR_CodeSystem_RETRACT "FHIR CodeSystem Retract" "Retraction of a previously-published FHIR CodeSystem identified by the entry's contentItemIdentifier and contentItemVersion."
* #FHIR_ValueSet_RETRACT "FHIR ValueSet Retract" "Retraction of a previously-published FHIR ValueSet."
* #FHIR_ConceptMap_RETRACT "FHIR ConceptMap Retract" "Retraction of a previously-published FHIR ConceptMap."
* #FHIR_StructureDefinition_RETRACT "FHIR StructureDefinition Retract" "Retraction of a previously-published FHIR StructureDefinition."
