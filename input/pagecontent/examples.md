### Examples

Annotated feed fragments illustrating the format.

### A SNOMED CT International Edition entry

```xml
<entry>
  <title>SNOMED CT International Edition-April 2023 v1.0 (RF2 FULL PACKAGE)</title>
  <link rel="alternate" type="application/zip"
        href="https://mlds.ihtsdotools.org/api/releasePackages/167/releaseVersions/966543/releaseFiles/966545/download"
        length="533422481"
        sct:md5Hash="0290ad7f6e431063166afd91cd2b8c37"/>
  <link rel="related" type="application/pdf"
        href="https://mlds.ihtsdotools.org/api/releasePackages/167/releaseVersions/966543/releaseFiles/966825/download"
        length="80605"
        sct:md5Hash="505ca7d8bca26770e1e310c0a49a65f3"/>
  <category term="SCT_RF2_FULL" label="SNOMED CT RF2 Full"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <author>
    <name>SNOMED International</name>
    <uri>https://www.snomed.org</uri>
    <email>info@snomed.org</email>
  </author>
  <id>urn:uuid:3cca1feb-16f8-4c34-b5e4-692e70ae30ca</id>
  <updated>2023-09-20T14:02:22Z</updated>
  <published>2023-04-28T00:00:00Z</published>
  <summary>SNOMED International April 2023 SNOMED CT International Edition release package</summary>
  <rights>© International Health Terminology Standards Development Organisation 2002-2023. …</rights>
  <ncts:contentItemIdentifier>http://snomed.info/sct/900000000000207008</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://snomed.info/sct/900000000000207008/version/20230430</ncts:contentItemVersion>
</entry>
```

Notes:

- The primary download is `rel="alternate"`; release notes are
  `rel="related"`.
- `contentItemIdentifier` is the unversioned International Edition
  module URI; `contentItemVersion` adds `/version/20230430`.
- No `<sct:packageDependency>` because Editions have no dependencies.
- Hash uses legacy `sct:md5Hash`.

### A SNOMED CT extension entry with dependencies

```xml
<entry>
  <title>SNOMED CT-International Spanish Extension 2022-10-31 (RF2 SNAPSHOT)</title>
  <link rel="alternate" type="application/zip"
        href="https://mlds.ihtsdotools.org/api/.../download"
        length="266118090"
        sct:md5Hash="a8fc30a504960ce9e5adc956368f49ce"/>
  <category term="SCT_RF2_SNAPSHOT" label="SNOMED CT RF2 Snapshot"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <id>urn:uuid:f9df5b1f-bbd3-4b25-ac7c-13a2cfaa3184</id>
  <updated>2022-08-01T06:00:00Z</updated>
  <published>2022-08-04T06:00:00Z</published>
  <ncts:contentItemIdentifier>http://snomed.info/sct/450829007</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://snomed.info/sct/450829007/version/20221031</ncts:contentItemVersion>
  <sct:packageDependency>
    <sct:editionDependency>http://snomed.info/sct/900000000000207008/version/20220731</sct:editionDependency>
    <sct:derivativeDependency>http://snomed.info/sct/816211006/version/20220131</sct:derivativeDependency>
  </sct:packageDependency>
</entry>
```

Notes:

- Spanish Extension depends on a specific International Edition
  version *and* a derivative version. Both must be loaded first.

### A SNOMED CT-AU entry using SHA-256

```xml
<entry>
  <title>SNOMED CT-AU 30 November 2022 (RF2 FULL)</title>
  <link rel="alternate" type="application/zip"
        href="https://api.healthterminologies.gov.au/syndication/v1/au/.../...-FULL.zip"
        length="274406331"
        ncts:sha256Hash="8130cc90b38e8608380dd80e3b94740584270da5ae79f58d1a5281ac80809095"/>
  <category term="SCT_RF2_FULL" label="SNOMED CT RF2 Full"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <id>urn:uuid:5cfaebe3-c1dd-312a-a15a-79bfd9e4d9bb</id>
  <updated>2022-11-23T10:50:00Z</updated>
  <published>2022-11-23T10:50:00Z</published>
  <ncts:contentItemIdentifier>http://snomed.info/sct/32506021000036107</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://snomed.info/sct/32506021000036107/version/20221130</ncts:contentItemVersion>
</entry>
```

Notes:

- Uses `ncts:sha256Hash` instead of `sct:md5Hash`. Both are
  permitted; SHA-256 is preferred for new feeds.

### A FHIR ValueSet entry

```xml
<entry>
  <title>Australian Body Sites</title>
  <link rel="alternate" type="application/fhir+json"
        href="https://example.org/fhir/ValueSet?url=http://example.org/fhir/ValueSet/au-body-sites&version=1.2.0"
        length="83291"
        ncts:sha256Hash="9c9b…"/>
  <category term="FHIR_ValueSet" label="FHIR ValueSet"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <id>urn:uuid:1e7c3f92-6e2a-4c03-9f70-aa20b91b2c04</id>
  <updated>2024-06-15T09:00:00Z</updated>
  <published>2024-06-15T09:00:00Z</published>
  <ncts:contentItemIdentifier>http://example.org/fhir/ValueSet/au-body-sites</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://example.org/fhir/ValueSet/au-body-sites|1.2.0</ncts:contentItemVersion>
  <ncts:fhirVersion>4.0.1</ncts:fhirVersion>
</entry>
```

Notes:

- `<published>` matches `ValueSet.date`; `contentItemIdentifier`
  matches `ValueSet.url`; `contentItemVersion` matches
  `ValueSet.url|ValueSet.version`.
- `<ncts:fhirVersion>` is required because the category term is
  `FHIR_ValueSet`.

### A retract entry

```xml
<entry>
  <title>Australian Body Sites — RETRACTED</title>
  <category term="FHIR_ValueSet_RETRACT" label="FHIR ValueSet Retract"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <link rel="related" type="application/pdf"
        href="https://example.org/notices/au-body-sites-1.2.0-retraction.pdf"
        length="14238"
        ncts:sha256Hash="ee44…"/>
  <id>urn:uuid:5c1f…</id>
  <updated>2024-08-02T11:00:00Z</updated>
  <published>2024-08-02T11:00:00Z</published>
  <ncts:contentItemIdentifier>http://example.org/fhir/ValueSet/au-body-sites</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://example.org/fhir/ValueSet/au-body-sites|1.2.0</ncts:contentItemVersion>
  <ncts:fhirVersion>4.0.1</ncts:fhirVersion>
</entry>
```

Notes:

- Retracts exactly the `1.2.0` version. To also retract `1.1.0`, a
  separate retract entry is needed.
- No `<link rel="alternate">`, by rule. The optional
  `rel="related"` link points to a deprecation notice.
- `<ncts:fhirVersion>` is still required (rule applies to any
  `FHIR_*` term, retract or not).
- A consumer that never had `1.2.0` installed silently no-ops.

### A FHIR Bundle entry

```xml
<entry>
  <title>Australian Concept Maps Bundle</title>
  <link rel="alternate" type="application/fhir+json"
        href="https://example.org/bundles/au-concept-maps-2024-06.json"
        length="2841920"
        ncts:sha256Hash="aa11…"/>
  <category term="FHIR_Bundle" label="FHIR Bundle"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <id>urn:uuid:7a44…</id>
  <updated>2024-06-15T09:00:00Z</updated>
  <ncts:contentItemIdentifier>http://example.org/fhir/Bundle/au-concept-maps</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://example.org/fhir/Bundle/au-concept-maps|2024-06</ncts:contentItemVersion>
  <ncts:fhirVersion>4.0.1</ncts:fhirVersion>
  <ncts:bundleInterpretation>collection</ncts:bundleInterpretation>
</entry>
```

Notes:

- Because the category is `FHIR_Bundle`, the entry MUST carry
  `<ncts:fhirVersion>`. The `<ncts:bundleInterpretation>` element is
  optional; when present (`batch` or `collection`) it hints at the
  publisher's view of the Bundle. The consumer remains free to
  handle the Bundle however it sees fit.
