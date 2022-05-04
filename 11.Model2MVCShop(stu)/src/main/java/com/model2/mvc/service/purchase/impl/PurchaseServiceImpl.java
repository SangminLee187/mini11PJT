package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductDao;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	///Field
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}
	
	///Constructor
	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public Purchase addPurchase(Purchase purchase) throws Exception {
		purchaseDao.insertPurchase(purchase);
		return purchase;
	}

	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.findPurchase(tranNo);
	}
	
	public Map<String, Object>getPurchaseList(Search search, String userId)throws Exception{
		
		Map map = new HashMap<>();
		map.put("userId", userId);
		map.put("search", search);
		
		List<Purchase> list = purchaseDao.getPurchaseList(map);
		
		return map;
	}	
	
	public Map<String, Object>getSaleList(Search search) throws Exception{
		return purchaseDao.getSaleList(search);
	}
	public Purchase updatePurchase(Purchase purchaseVO) throws Exception{
		purchaseDao.updatePurchase(purchaseVO);
		return purchaseVO;
	}
	
	public void updateTranCode(Purchase purchaseVO) throws Exception{
		purchaseDao.updateTranCode(purchaseVO);
	}
	
}