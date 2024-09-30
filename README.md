# Testing `rustls_post_quantum` CryptoProvider

This project provides a standalone server and client applications to test the `rustls_post_quantum` CryptoProvider. It adapts the [examples](https://github.com/rustls/rustls/tree/main/examples) (forked from tag `v/0.23.13`) code from the Rustls project we test TLS server and client that uuse post-quantum cryptographic algorithms for key exchange.

The `rustls_post_quantum` crate (available at [rustls-post-quantum](https://github.com/rustls/rustls/tree/main/rustls-post-quantum)) offers experimental support for post-quantum key exchange algorithms, specifically the **X25519Kyber768Draft00** algorithm in its current version. For detailed information about the `rustls_post_quantum` crate, refer to its [documentation](https://docs.rs/rustls-post-quantum/latest/rustls_post_quantum/).

## Setup

Clone the rustls GitHub repository to your local machine and check out the specific release (we used `v0.23.13` for development):

```bash
git clone https://github.com/rustls/rustls.git
cd rustls
git checkout v/0.23.13
```

Generate the certificates by running the `generate_certs.sh` script into the `certs` folder.

Build the project:

```bash
cd ../pq_tls
cargo build
```

## Testing

We've added a `--post-quantum` flag to both the server and client applications. This flag enables the use of post-quantum cryptography when present. Here's how to test with and without post-quantum cryptography:

### With PQC

Run the server:

```bash
cargo run --bin server -- --post-quantum --certs ../certs/server.fullchain --key ../certs/server.key -p 8443 echo
```

Run the Client:

```bash
echo hello world | cargo run --bin client -- --post-quantum --cafile ../certs/ca.cert -p 8443 localhost
```

### Default version without PQC

Run the server:

```bash
cargo run --bin server -- --certs ../certs/server.fullchain --key ../certs/server.key -p 8443 echo
```

Run the Client:

```bash
echo hello world | cargo run --bin client -- --cafile ../certs/ca.cert -p 8443 localhost
```

or

```bash
openssl s_client -ign_eof -quiet -connect localhost:8443
```