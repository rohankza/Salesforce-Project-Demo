
# Salesforce CPQ – Learning Topics & Summary

**Updated Date:** October 12, 2026


##  Salesforce Revenue Cloud: Create and Configure a Bundle

### Business Scenario
Create a parent bundle product with child products and make it available in Browse Catalogs.

### Implementation Steps
1. Open the Salesforce Revenue Cloud application.
2. Navigate to the Products or Product Catalog management area.
3. Create the parent bundle product.
4. Create the child products that will be included in the bundle.
5. Open the parent product.
6. Navigate to the **Product Structure** tab.
7. Add the required child products to the parent product structure.
8. Configure the appropriate child-product relationships and required settings.
9. Save the product structure.
10. Navigate to the Catalogs area.
11. Open the relevant catalog or create a new catalog.
12. Create or select the appropriate category.
13. Associate the parent bundle product with the catalog category.
14. Ensure that the product and catalog configuration meet the requirements for publication and availability.
15. Open **Browse Catalogs**.
16. Locate the parent bundle product and verify that it appears in the catalog.
17. Open the bundle and verify that its child products are available for configuration.


## 1. Salesforce CPQ: Bundle Product Discount

### Business Scenario
A Dell laptop bundle contains child products such as a keyboard and mouse.

- When the keyboard is added to the Dell laptop bundle, apply a 50% discount.
- When the keyboard is sold as a standalone product, charge the full price.

### Implementation Steps

1. Navigate to the Salesforce App Launcher and open **Salesforce CPQ**.
2. Open the Products tab and create or select the Dell laptop parent product.
3. Create the keyboard and mouse as child products.
4. Open the Dell laptop product and navigate to the **Related** tab.
5. Create Product Options for the keyboard and mouse.
6. Open the keyboard Product Option record.
7. Enable the **Discounted** checkbox.
8. Set the discount to 50% using the applicable bundle pricing configuration.
9. Save the Product Option.
10. Create a Quote and add the Dell laptop bundle.
11. Configure the bundle and verify that the keyboard receives the 50% discount.
12. Add the keyboard separately to another Quote and verify that its standalone price remains unchanged.

### Expected Result

- Keyboard inside the bundle: 50% discount.
- Keyboard sold separately: Full standalone price.

---

## 2. Salesforce CPQ: Price Rule Based on Quantity

### Business Scenario
When the quantity of a Quote Line Item exceeds 2, automatically apply a 10% discount.

### Implementation Steps

1. Navigate to **Setup → Object Manager → Price Rule** or open the Price Rules tab, depending on your configuration.
2. Create a new Price Rule.
3. Enter the Price Rule Name: `Discount Based on Quantity`.
4. Set **Evaluation Scope** to `Calculator`.
5. Set the appropriate Calculator Evaluation Event, such as `On Calculate`.
6. Create a Price Condition:
   - Tested Object: Quote 
   - Tested Field: SBQQ__LineItemCount__c
   - Operator: Greater Than
   - Filter Value: `2`
7. Create a Price Action:
   - Target Object: Quote Line
   - Target Field: `Discount (%)` or the appropriate discount field for your pricing setup.
   - Value: `10`, according to the target field's expected format.
8. Save and activate the Price Rule.
9. Create a Quote and add a product with a quantity greater than 2.
10. Click **Calculate** and verify the resulting discount.


**Note:** `SBQQ__AdditionalDiscount__c` represents the Additional Discount field. Confirm the field's availability and supported use in your CPQ configuration before using it as a Price Action target.

---

## 3. Salesforce CPQ: Price Rule Based on Product Code

### Business Scenario
Apply a 10% discount when the Product Code is `Dell-01`.

### Implementation Steps

1. Create a new Price Rule named `Discount Based on Product Code`.
2. Set Evaluation Scope to `Calculator`.
3. Set the appropriate Calculator Evaluation Event, such as `On Calculate`.
4. Create a Price Condition:
   - Tested Object: Quote Line
   - Tested Field: Product Code (`SBQQ__ProductCode__c`, if available in your configuration)
   - Operator: Equals
   - Filter Value: `Dell-01`
5. Create a Price Action:
   - Target Object: Quote Line
   - Target Field: Discount (AMT).
   - Value: `10`,
6. Save and activate the Price Rule.
7. Create a Quote and add the Dell product with Product Code `Dell-01`.
8. Click **Calculate**.
9. Verify that the 10% discount is applied.
10. Add another product with a different Product Code and confirm that the rule does not apply.

---

## 4. Salesforce CPQ: Custom Action on Quote Lines

### Business Scenario
Display a custom action button on individual Quote Lines for specific products.

### Implementation Steps

1. Open the Salesforce CPQ **Custom Actions** configuration.
2. Create a new Custom Action.
3. Enter the action name and label.
4. Configure the action's display settings:
   - **Location:** `Line`
   - **Page:** `Quote Line`
5. Configure the action's behavior according to the intended functionality.
6. Save the Custom Action.
7. Open the Quote Line Editor for a Quote.
8. Add the relevant products.
9. Verify that the action appears at the Quote Line level.
10. Test the action on the intended products and confirm that it performs the expected operation.

=============================================================

**Updated Date:** October 8, 2026

1. Product Images on Quote Lines

Implemented a feature to display Product Images directly on the Quote Line UI in Salesforce CPQ.
Implementation
Created the required Formula/URL fields to store and reference the Product Image URL.
Stored Product Images in the Document object.
Configured the images with public access so they can be loaded from the Quote Line UI.
Configured the required Image URL and related fields.
Displayed the respective Product Image against each Quote Line Product.
Outcome

Users can easily view the Product Image directly from the Quote Line UI.

2. Bookmarked/Favorite Product & Product Code
Implemented a Record-Triggered Flow to capture and display the Product Code of bookmarked/favorite products on Quote Lines.
Implementation
Created a Record-Triggered Flow to process bookmarked/favorite products.
Retrieved the related Favorite Product and Quote Line records.
Used a Loop to process the related Quote Lines.
Retrieved the Product Code from the related Product.
Assigned the Product Code to a custom Quote Line field.
Stored and displayed the Product Code on the Quote Line UI.
Outcome

Users can easily identify the Product Code of bookmarked/favorite products directly on Quote Lines.

3. Product Rules & Configuration Rules

Implemented Product Rules and Configuration Rules to automate product selection based on Configuration Attribute values during bundle configuration.
Implementation
Created a Configuration Attribute to capture the user's selection.
Created a Product Rule based on the selected Configuration Attribute value.
Configured the Product Rule to automatically select/add the required Product Option.
Created the required Configuration Rule.
Linked the Configuration Rule with the Product Bundle.
Configured the rule to execute during the Bundle Configuration process.
Example

When a user selects a specific Configuration Attribute value, the Product Rule automatically selects or adds the required product option within the bundle


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
