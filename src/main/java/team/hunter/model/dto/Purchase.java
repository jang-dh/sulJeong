package team.hunter.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Purchase {
	private int code;
	private int memberCode;
	private int fundingCode;
	private int price;
	private int qty;
	private String purchaseState;
	private String purchaseDate;
	private String deliveryNumber;
	private String Courier;
}
