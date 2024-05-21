# Cassandra Docker Example

This repository contains an implementation of various nodes of Apache Cassandra using Docker Compose. The project is designed to help you quickly set up and run a multi-node Cassandra cluster in a local environment using Docker.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Stopping the Cluster](#stopping-the-cluster)
- [License](#license)

## Introduction

Apache Cassandra is a highly scalable, high-performance distributed database designed to handle large amounts of data across many commodity servers without any single point of failure. This project uses Docker Compose to create a multi-node Cassandra cluster for development and testing purposes. 

For this example, the following model has been defined:
![image](https://github.com/pluque01/cassandra-docker-example/assets/45895450/17f80718-1b1f-499e-8723-5ffd284e7ad6)


## Prerequisites

Before you begin, ensure you have the following software installed on your local machine:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

1. Clone the repository to your local machine:

    ```sh
    git clone https://github.com/pluque01/cassandra-docker-example.git
    cd cassandra-docker-example
    ```

2. Start the Cassandra cluster using Docker Compose:

    ```sh
    docker compose up -d
    ```

    This command will download the necessary Docker images and start the Cassandra nodes defined in the `docker-compose.yml` file.

## Usage

Once the cluster is up and running, you can interact with it using the `cqlsh` tool.

1. Access the Cassandra query language shell on node 1:

    ```sh
    docker exec -it node1 cqlsh
    ```

2. You can now run CQL commands to create keyspaces, tables, and insert or query data.

## Configuration

The cluster configuration is defined in the `docker-compose.yml` file. Here you can adjust the number of nodes, ports, and other settings. By default, the configuration includes three Cassandra nodes:

```yaml
version: "3.8"

# https://cassandra.apache.org/doc/4.1/cassandra/configuration/cass_yaml_file.html
x-cassandra-env: &environment
  CASSANDRA_SEEDS: "node1,node2"
  CASSANDRA_CLUSTER_NAME: DDBCluster
  CASSANDRA_DC: DatacenterSWAP
  CASSANDRA_RACK: WorkRACK
  CASSANDRA_ENDPOINT_SNITCH: GossipingPropertyFileSnitch
  CASSANDRA_NUM_TOKENS: 128

networks:
  cassandra:

services:
  node1:
    image: cassandra:latest
    container_name: node1
    hostname: node1
    networks:
      - cassandra
    ports:
      - "9042:9042"
    volumes:
      - ./data.cql:/home/data.cql
    environment: *environment

  node2:
    image: cassandra:latest
    container_name: node2
    hostname: node2
    networks:
      - cassandra
    ports:
      - "9043:9042"
    environment: *environment
    depends_on:
      node1:
        condition: service_started

  node3:
    image: cassandra:latest
    container_name: node3
    hostname: node3
    networks:
      - cassandra
    ports:
      - "9044:9042"
    environment: *environment
    depends_on:
      node2:
        condition: service_started

```

## Stopping the Cluster

To stop the Cassandra cluster, run:

```sh
docker compose down
```

This will stop and remove all the containers defined in the `docker-compose.yml` file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Authors

- Miguel Tirado Guzmán
- Pablo Luque Salguero
