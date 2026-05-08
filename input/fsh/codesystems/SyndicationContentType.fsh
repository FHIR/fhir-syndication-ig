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
* #FHIR_Bundle "FHIR Bundle" "A FHIR Bundle resource. The entry's `bundleInterpretation` element specifies whether the consumer SHOULD process it as `batch` or `collection`."
* #FHIR_Package "FHIR Package" "A FHIR NPM (`tgz`) implementation guide / package."

// ── Other terminologies ───────────────────────────────────────────────────
* #LOINC "LOINC" "A LOINC release artefact."
