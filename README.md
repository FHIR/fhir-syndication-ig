# Terminology Syndication Feed IG

**Published:** <https://fhir.github.io/fhir-syndication-ig/>

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

Requires SUSHI v3+ and (for the full IG) Java 17+ and the HL7 FHIR IG
Publisher.

```sh
# FSH only — fast, no IG Publisher
sushi .

# Full IG build
./_updatePublisher.sh   # one-off: fetch publisher.jar into input-cache/
./_genonce.sh           # SUSHI + IG Publisher → output/
```

Windows: `_updatePublisher.bat` and `_genonce.bat`.

## Continuous build

`.github/workflows/build.yml` runs the full IG Publisher build on
every push to `main` and on every PR. The `main`-branch build is
deployed to GitHub Pages (`output/` → site root). Per-run artefacts
are kept for 14 days.

To enable Pages deployment: in repo settings → Pages, set source to
"GitHub Actions". The first push to `main` will populate the site.

## HL7 auto-builder

To have the HL7 auto-builder at <https://build.fhir.org/ig/> rebuild
this IG on every push:

1. Push the repo to a public GitHub repository.
2. Open a PR against
   <https://github.com/FHIR/ig-registry> adding this repo to
   `fhir-ig-list.json`.

The HL7 auto-builder reads `ig.ini` and the standard `_genonce.sh` /
`_updatePublisher.sh` scripts that this repo already provides.

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
