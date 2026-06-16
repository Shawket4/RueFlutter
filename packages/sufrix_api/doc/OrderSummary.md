# sufrix_api.model.OrderSummary

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**completed** | **int** |  | 
**deliveryFees** | **int** | Total delivery charges (piastres) across completed orders in scope. Lets the dashboard surface delivery revenue separately from item sales. | [optional] 
**deliveryOrders** | **int** | Count of completed delivery orders. | [optional] 
**deliveryRevenue** | **int** | Gross revenue (total_amount) of completed delivery orders. | [optional] 
**discounts** | **int** |  | 
**inMallFees** | **int** |  | [optional] 
**inMallOrders** | **int** | In-mall channel: order count / gross revenue / delivery fees. | [optional] 
**inMallRevenue** | **int** |  | [optional] 
**outsideFees** | **int** |  | [optional] 
**outsideOrders** | **int** | Outside channel: order count / gross revenue / delivery fees. | [optional] 
**outsideRevenue** | **int** |  | [optional] 
**revenue** | **int** |  | 
**tips** | **int** |  | 
**voided** | **int** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


