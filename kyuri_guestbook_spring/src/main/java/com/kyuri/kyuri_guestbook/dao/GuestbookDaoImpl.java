package com.kyuri.kyuri_guestbook.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kyuri.kyuri_guestbook.domain.Guestbook;

public class GuestbookDaoImpl implements GuestbookDao {
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Guestbook> selectAllList() {
		@SuppressWarnings("unchecked")
		List<Guestbook> users = (List<Guestbook>) sqlSession.selectList("selectAllList");
		return users;
	}
}
