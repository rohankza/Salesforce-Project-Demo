public with sharing class SoqlQueryController {

    public class QueryResponse {
        @AuraEnabled public List<String> columns { get; set; }
        @AuraEnabled public List<Map<String, Object>> rows { get; set; }
        @AuraEnabled public Integer totalRows { get; set; }

        public QueryResponse() {
            columns = new List<String>();
            rows = new List<Map<String, Object>>();
            totalRows = 0;
        }
    }

    @AuraEnabled
    public static QueryResponse runQuery(String soql) {
        if (String.isBlank(soql)) {
            throw new AuraHandledException(
                'Please enter a SOQL query.'
            );
        }

        String normalized = soql.trim();

        // Starter guard only, not a complete SOQL parser.
        if (!normalized.toUpperCase().startsWith('SELECT ')) {
            throw new AuraHandledException(
                'Only SELECT queries are supported.'
            );
        }

        if (normalized.contains(';')) {
            throw new AuraHandledException(
                'Multiple statements are not supported.'
            );
        }

        try {
            List<SObject> records = Database.queryWithBinds(
                normalized,
                new Map<String, Object>(),
                AccessLevel.USER_MODE
            );

            QueryResponse response = new QueryResponse();
            response.totalRows = records.size();

            if (!records.isEmpty()) {
                response.columns.addAll(
                    records[0].getPopulatedFieldsAsMap().keySet()
                );
            }

            for (SObject record : records) {
                Map<String, Object> row = new Map<String, Object>();

                for (String fieldName : response.columns) {
                    Object value = record.get(fieldName);

                    row.put(
                        fieldName,
                        value == null ? null : String.valueOf(value)
                    );
                }

                response.rows.add(row);
            }

            return response;

        } catch (Exception e) {
            throw new AuraHandledException(
                'Query failed. Check your SOQL and object/field access.'
            );
        }
    }
}