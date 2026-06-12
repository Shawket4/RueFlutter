# sufrix_api.model.ShiftReportResponse

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**cashMovements** | [**List&lt;CashMovementSummaryRow&gt;**](CashMovementSummaryRow.md) |  | 
**cashMovementsIn** | **int** |  | 
**cashMovementsNet** | **int** | Net of all cash movements (in - out) as a signed integer | 
**cashMovementsOut** | **int** |  | 
**netPayments** | **int** |  | 
**paymentSummary** | [**List&lt;PaymentSummaryRow&gt;**](PaymentSummaryRow.md) |  | 
**printedAt** | [**DateTime**](DateTime.md) |  | 
**shift** | [**Shift**](Shift.md) |  | 
**totalPayments** | **int** |  | 
**voidedAmount** | **int** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


