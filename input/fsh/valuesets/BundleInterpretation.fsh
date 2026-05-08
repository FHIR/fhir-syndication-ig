ValueSet: BundleInterpretationVS
Id: bundle-interpretation
Title: "FHIR Bundle Interpretation"
Description: """
Permitted values for the `ncts:bundleInterpretation` element on an
entry whose artefact is a FHIR Bundle. Indicates how the consumer
SHOULD load the bundle.
"""
* ^url = "https://ontoserver.csiro.au/syndication/ValueSet/bundle-interpretation"
* http://hl7.org/fhir/bundle-type#batch "Batch"
* http://hl7.org/fhir/bundle-type#collection "Collection"
