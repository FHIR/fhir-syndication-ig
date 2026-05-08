ValueSet: BundleInterpretationVS
Id: bundle-interpretation
Title: "FHIR Bundle Interpretation"
Description: """
Permitted values for the `ncts:bundleInterpretation` element on an
entry whose artefact is a FHIR Bundle. Hints at the publisher's
view of the Bundle's contents. The consumer is not obliged to
follow the hint.
"""
* ^url = "https://ontoserver.csiro.au/syndication/ValueSet/bundle-interpretation"
* ^experimental = false
* http://hl7.org/fhir/bundle-type#batch "Batch"
* http://hl7.org/fhir/bundle-type#collection "Collection"
