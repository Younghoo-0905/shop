package vo;

public class Category {
	private String categoryName;
	private String updateDate;
	private String createDate;
	private String categoryState;
	
	@Override
	public String toString() {
		return "Category [categoryName=" + categoryName + ", updateDate=" + updateDate + ", createDate=" + createDate
				+ ", categoryState=" + categoryState + "]";
	}	
	
	public String getCategoryState() {
		return categoryState;
	}
	public void setCategoryState(String categoryState) {
		this.categoryState = categoryState;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
}
