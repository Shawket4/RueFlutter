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
**expectedCash** | **int** | Authoritative system (expected) cash in the drawer. For a closed shift this is the snapshot taken at close (`closing_cash_system`); for an open shift it is computed live via the same formula. Clients should display this directly instead of re-deriving it from the payment breakdown. | 
**netPayments** | **int** |  | 
**paymentSummary** | [**List&lt;PaymentSummaryRow&gt;**](PaymentSummaryRow.md) |  | 
**printedAt** | [**DateTime**](DateTime.md) |  | 
**shift** | [**Shift**](Shift.md) |  | 
**totalPayments** | **int** |  | 
**voidedAmount** | **int** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


