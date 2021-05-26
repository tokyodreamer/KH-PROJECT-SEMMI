package semi.category.beans;

public class CategoryDto {
	private int categoryNo;
	private String categoryType;
	private String categoryAuth;
	
	public CategoryDto() {
		super();
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}

	public String getCategoryAuth() {
		return categoryAuth;
	}

	public void setCategoryAuth(String categoryAuth) {
		this.categoryAuth = categoryAuth;
	}
	
}
