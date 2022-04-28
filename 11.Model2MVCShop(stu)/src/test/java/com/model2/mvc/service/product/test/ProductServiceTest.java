package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })

@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Test
	public void testAddProduct() throws Exception {
		
		Product prod = new Product();
		prod.setProdNo(77777);
		prod.setProdName("���");
		prod.setProdDetail("������");
		prod.setManuDate("220407");
		prod.setPrice(88888);
		prod.setFileName("�����̸�");
		
		productService.addProduct(prod);
		
		prod = productService.getProduct(prod.getProdNo());
		
		//==> console Ȯ��
		System.out.println(prod);
		
		//==> API Ȯ��

		Assert.assertEquals("���", prod.getProdName());
		Assert.assertEquals("������", prod.getProdDetail());
		Assert.assertEquals("220407", prod.getManuDate());
		Assert.assertEquals(88888, prod.getPrice());
		Assert.assertEquals("�����̸�", prod.getFileName());

	}
	
	//@Test
	public void testGetProduct() throws Exception {
		
		Product prod = new Product();

//			###������Ʈ�� ������###
//		prod.setProdNo(77777);
//		prod.setProdName("���");
//		prod.setProdDetail("������");
//		prod.setManuDate("220407");
//		prod.setPrice(88888);
//		prod.setFileName("�����̸�");
		
		prod = productService.getProduct(77777);

		//==> console Ȯ��
		//System.out.println(user);
		
		//==> API Ȯ��
		Assert.assertEquals("���", prod.getProdName());
		Assert.assertEquals("������", prod.getProdDetail());
		Assert.assertEquals("220407", prod.getManuDate());
		Assert.assertEquals(88888, prod.getPrice());
		Assert.assertEquals("�����̸�", prod.getFileName());

//		Assert.assertNotNull(productService.getProduct(11111));
//		Assert.assertNotNull(productService.getProduct(33333));
		Assert.assertNotNull(productService.getProduct(77777));

	}
	
	//@Test
	 public void testUpdateProduct() throws Exception{
		 
		Product prod = productService.getProduct(77777);
		Assert.assertNotNull(prod);
		
		Assert.assertEquals("���", prod.getProdName());
		Assert.assertEquals("������", prod.getProdDetail());
		Assert.assertEquals("220407", prod.getManuDate());
		Assert.assertEquals(88888, prod.getPrice());
		Assert.assertEquals("�����̸�", prod.getFileName());

		prod.setProdName("���77");
		prod.setProdDetail("������77");
		prod.setManuDate("220408");
		prod.setPrice(77777);
		prod.setFileName("�����̸�77");
		
		productService.updateProduct(prod);
		
		prod = productService.getProduct(77777);
		Assert.assertNotNull(prod);
		
		//==> console Ȯ��
		//System.out.println(user);
			
		//==> API Ȯ��
		Assert.assertEquals("���77", prod.getProdName());
		Assert.assertEquals("������77", prod.getProdDetail());
		Assert.assertEquals("220408", prod.getManuDate());
		Assert.assertEquals(77777, prod.getPrice());
		Assert.assertEquals("�����̸�77", prod.getFileName());
	 }

	
	 //==>  �ּ��� Ǯ�� �����ϸ�....
//	 @Test
	 public void testGetProductListAll() throws Exception{
System.out.println("===== getProductListAll START =====");

	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(18, list.size());
	 	
		//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
System.out.println(totalCount);
	 		 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(18, list.size());
	 	
	 	//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
System.out.println(totalCount);
System.out.println("===== getProductListAll END =====");
	 }
	 
//	 @Test
	 public void testGetProductListByProductNo() throws Exception{
System.out.println("===== getProductList prodNo START =====");

	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("77777");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 		 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
System.out.println("===== getProductList prodNo END =====");
	 }
	 
//	 @Test
	 public void testGetProductListByProductName() throws Exception{
System.out.println("===== getProductList prodName START =====");

	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("���");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 		 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
System.out.println("===== getProductList prodName END =====");
	 }

	 
//	 	 @Test
	 public void testGetProductListByPrice() throws Exception{
System.out.println("===== getProductList Price START =====");

	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword("88888");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 		 	
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
System.out.println("===== getProductList Price END =====");
	 }
}