### SNOMED CT Extensions

**Namespace URI:** `http://snomed.info/syndication/sct-extension/1.0.0`
**Conventional prefix:** `sct`

The SNOMED CT extension namespace carries SNOMED-specific metadata —
package dependencies and the legacy MD5 file hash.

### Entry-level elements

#### `sct:packageDependency`

Inter-package dependencies for this SNOMED CT artefact. Present
only when the artefact is a SNOMED CT extension or derivative —
never on the International Edition itself.

| Cardinality | Type |
|-------------|------|
| 0..1 | container |

Contains zero or more of each of:

##### `sct:editionDependency`

Versioned SNOMED CT URI of an edition this package depends on.

| Cardinality | Type | Format |
|-------------|------|--------|
| 0..* | `xs:anyURI` | `http://snomed.info/sct/<moduleId>/version/<YYYYMMDD>` |

##### `sct:derivativeDependency`

Versioned SNOMED CT URI of a derivative this package depends on.

| Cardinality | Type | Format |
|-------------|------|--------|
| 0..* | `xs:anyURI` | `http://snomed.info/sct/<moduleId>/version/<YYYYMMDD>` |

A consumer MUST install all transitively-referenced edition and
derivative dependencies before installing the artefact.

### Link-level attributes

#### `sct:md5Hash`

Lowercase-hex MD5 of the artefact byte stream. 32 hex characters.
Used as an attribute on `<link>`.

`sct:md5Hash` is the legacy hash mechanism used by SNOMED
International release feeds. New publishers SHOULD use
`ncts:sha256Hash` instead, or in addition.

### Example

A SNOMED CT-International Spanish Extension entry depending on the
International Edition and another derivative:

```xml
<entry>
  <!-- … core Atom + ncts: elements omitted … -->
  <category term="SCT_RF2_SNAPSHOT" label="SNOMED CT RF2 Snapshot"
            scheme="http://ns.electronichealth.net.au/ncts/syndication/asf/scheme/1.0.0"/>
  <link rel="alternate" type="application/zip"
        href="https://mlds.ihtsdotools.org/api/.../download"
        length="266118090"
        sct:md5Hash="a8fc30a504960ce9e5adc956368f49ce"/>
  <ncts:contentItemIdentifier>http://snomed.info/sct/450829007</ncts:contentItemIdentifier>
  <ncts:contentItemVersion>http://snomed.info/sct/450829007/version/20221031</ncts:contentItemVersion>
  <sct:packageDependency>
    <sct:editionDependency>http://snomed.info/sct/900000000000207008/version/20220731</sct:editionDependency>
    <sct:derivativeDependency>http://snomed.info/sct/816211006/version/20220131</sct:derivativeDependency>
  </sct:packageDependency>
</entry>
```
