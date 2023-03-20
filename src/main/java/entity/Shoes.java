package entity;

public class Shoes {
	private int shoesID;
	private String shoesName;
	private double price;
	private String cover;

	public Shoes() {

	}

	public Shoes(int shoesID, String shoesName, double price, String cover) {
		this.shoesID = shoesID;
		this.shoesName = shoesName;
		this.setPrice(price);
		this.cover = cover;
	}

	public String getShoesName() {
		return shoesName;
	}

	public void setShoesName(String shoesName) {
		this.shoesName = shoesName;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	@Override
	public String toString() {
		return shoesID + shoesName + price + cover;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getShoesID() {
		return shoesID;
	}

	public void setShoesID(int shoesID) {
		this.shoesID = shoesID;
	}
}
