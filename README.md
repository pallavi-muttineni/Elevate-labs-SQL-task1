**E-commerce Database Schema Design**

-----

This repository contains the deliverables for Task 1: Database Setup and Schema Design. The objective was to learn how to create databases, tables, and define relationships using SQL, and to visually represent the database structure with an ER diagram.

## Domain Chosen

For this task, I chose an **E-commerce** system as the domain. This allowed for the design of a practical database schema involving various entities and relationships common in online retail.

## Database Entities and Relationships

The core entities identified for this E-commerce database are:

  * **Customers**: Individuals who make purchases.
  * **Products**: Items available for sale.
  * **Categories**: Classifications for products (e.g., Electronics, Apparel).
  * **Suppliers**: Companies that provide products.
  * **Orders**: Records of customer purchases.
  * **Order Items**: Details of specific products within an order, linking products to orders.

The relationships between these entities are defined as follows:

  * A **Customer** can place many **Orders** (One-to-Many).
  * An **Order** contains many **Order Items** (One-to-Many).
  * A **Product** can be part of many **Order Items** (One-to-Many).
  * An **Order Item** links a specific **Order** to a specific **Product** (Many-to-Many resolved via `Order_Items` junction table).
  * A **Product** belongs to one **Category** (Many-to-One).
  * A **Product** is supplied by one **Supplier** (Many-to-One).

## Deliverables

### 1\. SQL Schema Script (`ecommerce_schema.sql`)

This SQL script contains the `CREATE DATABASE` and `CREATE TABLE` statements for setting up the E-commerce database. It defines:

  * Table structures for `Categories`, `Suppliers`, `Products`, `Customers`, `Orders`, and `Order_Items`.
  * **Primary Keys** (`PRIMARY KEY`) for unique row identification.
  * **Foreign Keys** (`FOREIGN KEY`) to establish relationships and ensure referential integrity between tables.
  * Various data types and constraints (`NOT NULL`, `UNIQUE`, `AUTO_INCREMENT`, `DEFAULT`, `ENUM`).
  * Includes `INSERT` statements for sample data to help with testing and demonstration.

### 2\. ER Diagram (`ecommerce_erd.png` / `ecommerce_erd.drawio`)

The Entity-Relationship (ER) diagram visually represents the designed database schema. It illustrates:

  * **Entities** (tables) as rectangles.
  * **Attributes** (columns) within each entity, with primary keys highlighted.
  * **Relationships** between entities, indicated by lines with **Crow's Foot Notation** to show cardinality (e.g., 1:M for One-to-Many).
  * 
-----![ER TASK1](https://github.com/user-attachments/assets/e37591a1-5cce-4dea-8ab7-9f9c7f49be45)

The ER diagram was created using MySQL Workbench

## How to Use

1.  **Clone the Repository:**
    ```bash
    git clone [your-repo-link]
    cd [your-repo-name]
    ```
2.  **Execute the SQL Script:**
      * Open your preferred SQL client (e.g., MySQL Workbench, pgAdmin, DBeaver, command line client).
      * Connect to your MySQL (or compatible) database server.
      * Execute the `ecommerce_schema.sql` script. This will create the `ecommerce_db` database and all the necessary tables with sample data.

## Key Concepts Demonstrated

This task helped reinforce understanding of several fundamental database concepts:

  * **DDL (Data Definition Language)**: Commands like `CREATE DATABASE` and `CREATE TABLE`.
  * **Normalization**: Designing tables to reduce redundancy and improve data integrity (aiming for 3NF).
  * **ER Diagrams**: Visualizing database structure and relationships.
  * **Primary Keys**: Unique identifiers for table rows.
  * **Foreign Keys**: Links between tables, enforcing referential integrity.
  * **Constraints**: Rules that maintain data accuracy and consistency.
  * **`AUTO_INCREMENT`**: Automatic generation of unique identifiers for primary keys.

