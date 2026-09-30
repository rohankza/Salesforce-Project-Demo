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
