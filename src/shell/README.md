# DataShop Web Services API - Bash Implementation

A [bash script](./datashop) that provides access and executes a request to the DataShop Web Services API.

## Installation

1. Install `openssl`, `base64`, `jq`, and `curl`, each on the `PATH`, accessible to bash.
1. Download the [script](./datashop) to your desired location. Add the script to the `PATH` if you want to run the script from any location.
1. Run the script, following the [usage information](#usage) below.

## Usage

```bash
datashop [options] [method] url-path [post-data]
```

### Options

Option                | Shortcode | Description
:---:                 | :---:     | :---
`--help`              | `-h`      | Displays the help message.
`--access-key-id`     | `-i`      | Access Key Id for [authorization](#access-key-authorization)
`--secret-access-key` | `-s`      | Secret Access Key [authorization](#access-key-authorization)
`--base-url`          | `-u`      | [Base URL](#url-explanation) to query the WebServices API from
`--output`            | `-o`      | Output file to write the response of the HTTP request

### Parameters

Parameter   | Default                    | Description
:---:       | :---:                      | :---
`method`    | `GET`                      | HTTP method
`url-path`  | Required                   | [Path of the URL](#url-explanation) to query
`post-data` | Required for `POST` method | File name or data to send for a `POST` request

## URL Explanation

The Web Services API requires an HMAC SHA1 signature to verify the authenticity of the request. This signature takes in part of the URL to sign the request. The URL is broken into four parts: the base URL (via `--base-url`), the services endpoint, the path of the URL (via `url-path`), and the query parameters.

For example:

```bash
# Base URL:         https://pslcdatashop.web.cmu.edu
# Services:         /services
# URL Path:         /datasets/1142
# Query Parameters: ?verbose=true
https://pslcdatashop.web.cmu.edu/services/datasets/1142?verbose=true
```

## Access Key Authorization

The Web Services API requires an HMAC SHA1 signature to verify the authenticity of the request. To create the signature, the raw data is signed with a secret access key and sent with an access key id as part of the `Authorization` header. These access keys are generated using the [Web Services credentials site](https://pslcdatashop.web.cmu.edu/WebServicesCredentials).

There are four places the access keys can be specified, where ones higher on the list are prioritized:

Location                  | Access Key Id Parameter  | Secret Access Key Parameter
:---:                     | :---:                    | :---:
`datashop` Argument       | `--access-key-id` / `-i` | `--secret-access-key` / `-s`
Local `.env`              | `DATASHOP_ACCESS_KEY_ID` | `DATASHOP_SECRET_ACCESS_KEY`
`~/.datashop/credentials` | `DATASHOP_ACCESS_KEY_ID` | `DATASHOP_SECRET_ACCESS_KEY`
Environment Variable      | `DATASHOP_ACCESS_KEY_ID` | `DATASHOP_SECRET_ACCESS_KEY`

Environment files are specified as `<key>=<value>` pairs. Comments and empty lines are ignored.
