package com.kyuri.kyuri_guestbook.dao;

import java.util.List;

import com.kyuri.kyuri_guestbook.domain.Guestbook;

public interface GuestbookDao {
	List<Guestbook> selectAllList();
}
