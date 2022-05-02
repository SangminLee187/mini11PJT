package com.model2.mvc.web.purchase;

import java.lang.annotation.Repeatable;
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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase")Purchase purchase, Model model) throws Exception{
		System.out.println("/addPurchase : POST");

		purchaseService.addPurchase(purchase);

		return "forward:/purchase/addPurchase.jsp"; 
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)	//View
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception{
		System.out.println("/addPurchase : GET");

		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);

		return "forward:/purchase/addPurchaseView.jsp"; 
	}
	
	@RequestMapping("/getPurchase")
	public String getPurchase(@RequestParam("tranNo")int tranNo, Model model) throws Exception{
		
		System.out.println("/getPurchase");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("pruchase", purchase);
		
		model.addAttribute("tranNo", tranNo);

		return "forward:/purchase/getPurchase.jsp";	
	}
	
	@RequestMapping("/getPurchaseList")
	public ModelAndView getPurchaseList(@ModelAttribute("search")Search search, 
								HttpSession session , Model model) throws Exception{
		
		String sessionId=((User)session.getAttribute("user")).getUserId();

		System.out.println("/PurchaseList");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = purchaseService.getPurchaseList(search,sessionId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
//	
//	@RequestMapping(value="updateProduct", method = RequestMethod.POST)
//	public String updateProduct(@ModelAttribute("product")Product product, Model model) throws Exception{
//		
//		System.out.println("/updateProduct");
//	
//		productService.updateProduct(product);
//				
//		model.addAttribute("product", product);
//		
//		return "redirect:/getProduct?menu=manage&prodNo="+product.getProdNo();
//	}
//	
//	@RequestMapping(value="updateProduct", method = RequestMethod.GET)
//	public String updateProduct(@RequestParam("prodNo")int prodNo, Model model) throws Exception{
//		
//		System.out.println("/updateProductView");
//		
//		Product product = productService.getProduct(prodNo);
//		
//		model.addAttribute("product", product);
//		
//		return "forward:/product/updateProduct.jsp";
//	}
	
}