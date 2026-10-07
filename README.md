# Salesforce CPQ – Learning Topics & Summary

**Updated Date:** October 7, 2026
**Salesforce CPQ – Implemented Scenarios**
I implemented the following scenarios using a Samsung 5G Phone Package bundle:
**Contract Pricing Scenario**
Implemented customer-specific contract pricing where eligible customers receive negotiated pricing for the Samsung 5G Phone.
**Option Constraint Scenario**
Implemented constraints between Premium Support and Standard Support to prevent incompatible options from being selected together.
**Configuration Attribute Scenario**
Implemented RAM, Storage, and Color as configurable attributes so customers can customize the phone during configuration.
**Product Rule Scenario**
Implemented product rules to validate and control product options based on selected RAM, Storage, and Color values.
**Price Rule Scenario**
Implemented dynamic pricing where selecting 16 GB RAM adds $500 to the base phone price.
**Discount Schedule Scenario**
Implemented quantity-based discounts where the discount percentage increases based on the quantity of phones purchased.
**Bundle Configuration Scenario**
Configured the Samsung 5G Phone bundle with 5G SIM Card, Premium Support, and Standard Support, including appropriate selection and dependency rules.




**Updated Date:** September 30, 2026

---

## 1. Percent of Total (POT)

**Summary:**
Learned how Percent of Total pricing works in Salesforce CPQ, where the price of a product is calculated as a percentage of applicable quote line values.

**Key Learning:**

* Configured Percent of Total products.
* Created and configured related POT records.
* Understood how CPQ dynamically calculates percentage-based pricing.
* Learned practical use cases for service, support, and additional charges.

---

## 2. Option Constraints

**Summary:**
Learned how Option Constraints control which products can be selected together within a CPQ bundle.

**Key Learning:**

* Configured relationships between bundle options.
* Understood dependent and incompatible option relationships.
* Used constraints to prevent invalid product combinations.
* Learned how constraints guide users toward valid bundle configurations.

---

## 3. Twin Fields

**Summary:**
Learned how Twin Fields are used in Salesforce CPQ to transfer values between matching custom fields on related CPQ objects.

**Key Learning:**

* Understood the concept of matching fields between CPQ objects.
* Learned how field values can be carried from one CPQ record to another.
* Understood how Twin Fields can support Product Rules, Price Rules, and CPQ automation.
* Learned the importance of matching field API names and compatible field types.

---

## 4. Multi-Dimensional Quoting (MDQ)

**Summary:**
Learned how MDQ allows a subscription to be divided into multiple time-based segments, with different quantities, prices, discounts, or other values for each segment.

**Key Learning:**

* Understood the concept of subscription segments.
* Learned how quantity can change across different subscription periods.
* Learned how pricing can vary by segment.
* Understood practical use cases such as ramp-up and ramp-down subscriptions.

**Example:**

A 3-year Printer Maintenance Service subscription can have:

* Year 1 → 2 printers
* Year 2 → 3 printers
* Year 3 → 5 printers

MDQ allows each year to be configured independently.

---
**Updated Date:** october 1 , 2026
## 5. Guided Selling

**Summary:**
Guided Selling helps users select the right products by asking predefined questions. It uses **Quote Processes, Process Inputs, Product Fields, and Conditions** to filter products.

**Example:**
Mapping **Service Type** and **Hardware Type** to relevant products.

**Key Learning:**

* Understood the Guided Selling process.
* Learned how predefined questions guide product selection.
* Learned how Process Inputs and Conditions can filter products.
* Understood how Guided Selling improves the product selection experience.

---

## 6. Custom Action in QLE

**Summary:**
A Custom Action adds a customized button or operation in the **Quote Line Editor (QLE)**. It can perform specific business logic on quote lines.

**Example:**
A **Reset Discount** button that resets discounts on selected quote lines.

**Key Learning:**

* Understood the purpose of Custom Actions.
* Learned how Custom Actions can be added to the QLE.
* Understood how actions can perform specific business operations.
* Learned a practical use case for resetting quote line discounts.

---

## 7. Salesforce CPQ Subscription Amendment

**Summary:**
Subscription Amendment allows users to modify an existing subscription contract. It creates an **Amendment Opportunity** linked to the existing contract.

**Key Learning:**

* Understood the Subscription Amendment process.
* Learned how an existing subscription can be modified.
* Understood the relationship between the Contract and Amendment Opportunity.
* Learned how amended subscription products are managed during the amendment process.

---

## 8. `SBQQ__AmendedContract__c` Permission Error

**Issue:**
During the Subscription Amendment process, I troubleshot the **`SBQQ__AmendedContract__c` permission error**.

**Why This Error Occurs:**

* The CPQ Amendment process requires access to the **Amended Contract** field.
* If the user's Profile or Permission Set does not provide the required field access, CPQ can throw a permission error.
* The field-level permissions should be verified for the relevant Contract object.

**Resolution:**

Navigate to:

**Setup → Object Manager → Contract → Fields & Relationships → `SBQQ__AmendedContract__c` → Field-Level Security**

Then provide the required **Read/Edit** access through the appropriate **Permission Set or Profile**, based on the user's CPQ requirements.

---

## Key CPQ Topics Covered

* Percent of Total (POT)
* Option Constraints
* Twin Fields
* Multi-Dimensional Quoting (MDQ)
* Guided Selling
* Quote Processes
* Process Inputs
* Product Fields
* Conditions
* Custom Actions
* Quote Line Editor (QLE)
* Subscription Amendment
* Amendment Opportunity
* Field-Level Security (FLS)
* `SBQQ__AmendedContract__c` troubleshooting
