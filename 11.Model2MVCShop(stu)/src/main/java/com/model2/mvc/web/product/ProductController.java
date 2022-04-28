package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping("/addProduct")
//	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product")Product product) throws Exception{
		System.out.println("/addProduct : POST");
		
		productService.addProduct(product);
		
		return "forward:/product/readProduct.jsp"; 
	}
	
	@RequestMapping("/getProduct")
	public String getProduct(@RequestParam("prodNo")int prodNo, Model model,
							@RequestParam("menu")String menu) throws Exception{
		
		System.out.println("/getProduct");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
System.out.println("menu : "+menu);			//menu�� Ȯ��

			if(menu==null || menu.equals("")) {
				menu = "other";
				return "forward:/product/readProduct.jsp";	
			}
			
			if(menu.equals("manage")) {
				return "forward:/product/updateProduct.jsp";
			}
		model.addAttribute("menu", menu);
		model.addAttribute("prodNo", prodNo);

		return "forward:/product/getProduct.jsp?menu="+menu;	
	}
	
	@RequestMapping("/listProduct")
	public String listProduct(@ModelAttribute("search")Search search, Model model) throws Exception{
		
		System.out.println("/listProduct");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);		
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method = RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product")Product product, Model model) throws Exception{
		
		System.out.println("/updateProduct : POST");
	
		productService.updateProduct(product);
				
		model.addAttribute("product", product);
		
		return "redirect:/product/getProduct?menu=manage&prodNo="+product.getProdNo();
	}
	
	@RequestMapping(value="updateProduct", method = RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo")int prodNo, Model model) throws Exception{
		
		System.out.println("/updateProductView : GET");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
}