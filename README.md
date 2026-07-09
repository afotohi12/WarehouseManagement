

# Warehouse Management System

A professional warehouse management application built with:

- Delphi
- FireDAC
- Microsoft SQL Server

## Features

- Automatic database creation
- Database migration system
- Version controlled SQL scripts
- User authentication
- Role and permission structure
- Warehouse and product management foundation

## Architecture

The project uses a layered architecture:

- Core
- Database
- Security
- Services
- Forms

## Database Migration

Database changes are managed using versioned migration scripts.

Example:

VERSION:1
VERSION:2
VERSION:3

Each migration is executed only once and tracked by checksum.

## Requirements

- Delphi RAD Studio
- SQL Server 2022



## Project structure 

```text
WarehouseManagement
│
├── Data
│   ├── Connection Management
│   └── Database Access
│
├── Database
│   └── SQL Migration Scripts
│
├── Security
│   ├── Password Hashing
│   ├── Authentication
│   └── User Session
│
└── Forms
    └── User Interface
```

## Development Status

Currently implemented:

✔ Database initialization  
✔ SQL migration system  
✔ User security foundation  
✔ Role and permission schema  
✔ Warehouse and product database foundation  

In progress:

- Login UI
- Product management
- Inventory transactions
- Reports