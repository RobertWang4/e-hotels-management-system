# e-Hotels Management System
**Course**: CS12132 Databases I - University of Ottawa  
**Academic Year**: 2025-2026 Winter  
**Instructor**: Verena Kantere

---

## 1. Project Overview
The **e-Hotels** application is a collaborative real-time room booking system developed by five major hotel chains. The system allows customers to browse and book rooms across North America while enabling hotel employees to manage check-ins, rentals, and payments.

---

## 2. Core Requirements

### System Scale
* **Hotel Chains**: 5 distinct chains with central office address, hotel count, email, and phone.
* **Hotels**: Each chain must have at least 8 hotels in at least 14 different North American locations.
* **Rooms**: Each hotel must have at least 5 rooms of different capacities.

### Key Entities & Attributes
* **Hotels**: Categorized by star ratings (1-star to 5-star).
* **Rooms**: Track price, amenities (TV, AC, fridge), capacity (single, double, etc.), view (sea/mountain), extendability, and damage status.
* **Customers**: Full name, address, ID type (SSN/SIN/Driving license), and registration date.
* **Employees**: Full name, address, SSN/SIN, and specific roles. Every hotel must have a manager.

### Business Logic
* **Booking to Renting**: Customers book online; upon check-in, an employee transforms the booking into a renting.
* **Direct Renting**: Employees can process walk-in rentals without a prior booking.
* **Data Persistence**: Archived booking/renting history must remain even if the room or customer record is deleted.
* **Cascading Deletes**: Deleting a chain deletes its hotels; deleting a hotel deletes its rooms.

---

## 3. Technical Requirements
* **Database**: PostgreSQL/MySQL (Raw SQL recommended).
* **Constraints**: Implementation of Primary Keys, Foreign Keys, Check constraints, and creative User-defined constraints.
* **Queries**: At least 4 queries, including 1 aggregation and 1 nested query.
* **Triggers**: At least 2 triggers for database modifications and constraint enforcement.
* **Optimization**: Implementation of 3 Indexes with justification.
* **Views**: 2 specific SQL Views: 
    1. Number of available rooms per area.
    2. Aggregated capacity of all rooms in a specific hotel.

---

## 4. Grading Criteria (Score Breakdown)

| Category | Requirement | Weight |
| :--- | :--- | :--- |
| **Design** | **1a.** ER Diagram & Justification | 10% |
| | **1b.** Relational Database Schema & Justification | 8% |
| | **1c.** Integrity Constraints (PK, FK, Domain, User-defined) | 7% |
| **Implementation**| **2a.** Database Implementation (SQL DDL) | 10% |
| | **2b.** Database Population (Test data for 5 chains/8 hotels each) | 5% |
| | **2c.** Database Queries (4 total: 1 Aggregate, 1 Nested) | 10% |
| | **2d.** Database Modifications (At least 2 Triggers) | 10% |
| | **2e.** Database Indexes (3 total with justification) | 5% |
| | **2f.** Database Views (2 specific SQL views) | 5% |
| **Application** | **2g.** Web Application / User Interface | 30% |
| **Total** | | **100%** |

---

## 5. Deliverables Timeline
* **1st Deliverable**: February 25, 2026 (Requirements 1a, 1b, 1c)
* **2nd Deliverable**: April 07, 2026 (Full application code, SQL code, and Presentation Video) 

---
