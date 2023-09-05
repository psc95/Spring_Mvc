package net.daum.vo;

//상품명과 상품가격을 저장하는 데이터 저장빈 클래스
public class ProductVO {
	
	private String name;
	private int price;
	
	public ProductVO() {}
	
	public ProductVO(String name,int price) {
		this.name=name;
		this.price=price;
	}//생성자 오버로딩

	public String getName() {
		return name;
	}

	public int getPrice() {
		return price;
	}
	
	
}
