# Salesforce CPQ – Learning Topics & Summary

## 1. Percent of Total (POT)

**Summary:**
Learned how Percent of Total pricing works in Salesforce CPQ, where the price of a product is calculated as a percentage of other applicable quote line values.

**Key Learning:**

* Configured Percent of Total products.
* Created and configured related POT records.
* Understood how CPQ calculates the percentage-based price dynamically.
* Learned practical use cases for service, support, and additional charges.

---

## 2. Option Constraints

**Summary:**
Learned how Option Constraints control which products can be selected together within a CPQ bundle.

**Key Learning:**

* Configured relationships between bundle options.
* Understood how constraints can make options dependent on or incompatible with other options.
* Used constraints to prevent invalid product combinations.
* Understood how constraints improve bundle configuration and guide users toward valid selections.

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



Updated Date: October 1, 2026

Salesforce CPQ Guided Selling

Guided Selling helps users select the right products by asking predefined questions. It uses Quote Processes, Process Inputs, Product Fields, and Conditions to filter products.

Example: Mapping Service Type and Hardware Type to relevant products.

Custom Action in QLE

A Custom Action adds a customized button or operation in the Quote Line Editor (QLE). It can perform specific business logic on quote lines.

Example: A Reset Discount button that resets discounts on selected quote lines.

Salesforce CPQ Subscription Amendment

Subscription Amendment allows users to modify an existing subscription contract. It creates an Amendment Opportunity linked to the existing contract.

SBQQ__AmendedContract__c Permission Error

I also troubleshot the SBQQ__AmendedContract__c permission error during the amendment process.

This error is usually faced when the user does not have the required Field-Level Security (FLS) permission for the SBQQ__AmendedContract__c field.

Why This Error Occurs
The CPQ Amendment process needs to read/write the Amended Contract field.
If the user's Profile or Permission Set does not provide the required field access, CPQ can throw a permission error.
The field access needs to be verified on the relevant Contract object.
Resolution

Navigate to:

Setup → Object Manager → Contract → Fields & Relationships → SBQQ__AmendedContract__c → Field-Level Security

Then provide the required Read/Edit access through the appropriate Permission Set or Profile, based on the user's CPQ requirements.

Key CPQ Topics Covered
Guided Selling
Quote Processes
Process Inputs
Product Fields
Conditions
Custom Actions
Quote Line Editor (QLE)
Subscription Amendment
Amendment Opportunity
Field-Level Security (FLS)
SBQQ__AmendedContract__c troubleshooting