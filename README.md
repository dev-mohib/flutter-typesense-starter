# Flutter Typesense 
eCommerce search product implementations using typesense and flutter.
## Get started
Read this [Article](https://coding-buddy.com/post/how-to-integrate-typesense-search-api-in-flutter-creating-ecommerce-app-using-typesense-flutter-and-bloc) to learn step-by-step guide.

## JSON file
https://raw.githubusercontent.com/algolia/datasets/refs/heads/master/ecommerce/bestbuy_seo.json

## Schema command
curl -X POST "http://localhost:8108/collections" \
-H "X-TYPESENSE-API-KEY: xyz" \
-H "Content-Type: application/json" \
-d '{
    "name": "products",
    "fields": [
        {"name": "name", "type": "string"},
        {"name": "shortDescription", "type": "string", "optional" : true},
        {"name": "bestSellingRank", "type": "int32","optional" : true},
        {"name": "thumbnailImage", "type": "string", "optional" : true},
        {"name": "salePrice", "type": "float"},
        {"name": "manufacturer", "type": "string", "optional" : true},
        {"name": "url", "type": "string", "optional" : true},
        {"name": "type", "type": "string", "optional": true},
        {"name": "image", "type": "string", "optional" : true},
        {"name": "customerReviewCount", "type": "int32", "optional": true},
        {"name": "shipping", "type": "string", "optional" : true },
        {"name": "salePrice_range", "type": "string", "otional": true},
        {"name": "objectID", "type": "string"},
        {"name": "categories", "type": "string[]", "facet": true, "optional": true}
    ],
    "default_sorting_field": "salePrice"
}'

## JSON to JSONL
https://yourgpt.ai/tools/json-to-jsonline


## Upload json
curl -X POST "http://localhost:8108/collections/products/documents/import?action=upsert" \
-H "X-TYPESENSE-API-KEY: xyz" \
-H "Content-Type: text/plain" \
--data-binary @products.jsonl


## Search 
curl -H "X-TYPESENSE-API-KEY: xyz" \
"http://localhost:8108/collections/products/documents/search\
?q=Bluetooth&query_by=name&filter_by=bestSellingRank:>100\
&sort_by=salePrice:desc"