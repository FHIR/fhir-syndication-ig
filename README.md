# Terminology Syndication Feed IG

FHIR Implementation Guide specifying the Atom-based terminology
syndication feed format. Documents the feed and entry shape, field
semantics, cross-field constraints, the controlled vocabularies used
in `<category>`, and the three extension namespaces:

- **NCTS ASF** — `http://ns.electronichealth.net.au/ncts/syndication/asf/extensions/1.0.0`
- **SNOMED CT** — `http://snomed.info/syndication/sct-extension/1.0.0`
- **Ontoserver** — `http://ontoserver.csiro.au/syndication/`

Canonical: `https://ontoserver.csiro.au/syndication`. Package id: `aehrc.syndication`.

This is a specification of the wire format. It does not document any
particular publisher's or consumer's behaviour.

## Build

Requires SUSHI v3+ and (for the full IG) the HL7 FHIR IG Publisher.

```sh
# FSH → resources only (fast, no IG Publisher)
sushi .

# Full IG build (downloads IG Publisher on first run)
./_genonce.sh   # provided by the IG template, see https://github.com/HL7/ig-publisher-scripts
```

## Layout

```
sushi-config.yaml        Sushi/IG config
ig.ini                   IG Publisher entry point
input/
  fsh/
    logicals/            Logical models for feed/entry shape
    codesystems/         Category-scheme code systems
    valuesets/           Bound value sets
    examples/            Worked examples
  pagecontent/           Narrative pages (markdown)
```
