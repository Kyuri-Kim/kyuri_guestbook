package com.kyuri.kyuri_guestbook;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.kyuri.kyuri_guestbook.dao.GuestbookDaoImpl;
import com.kyuri.kyuri_guestbook.domain.Guestbook;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	@Resource(name = "guestbookDao")
	private GuestbookDaoImpl guestbookDaoImpl;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
				DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@RequestMapping(value = "/selectAllList", method = RequestMethod.GET)
	public String selectAllUser(Locale locale, Model model) {

		List<Guestbook> lists = guestbookDaoImpl.selectAllList();

		Gson gson = new Gson();
		String out = gson.toJson(lists);
		model.addAttribute("data", out);

		return "dbtest";
	}
}
