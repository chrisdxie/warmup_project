"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class Tester(testLib.RestTestCase):
    """Test logging in users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)


class TestAddingUser(Tester):
    """More robust testing of adding users than testSimple.py"""

    def testAdd2(self):
        """Password is too long"""
        respData = self.makeRequest("/users/add", method='POST', data = {'user':'Yeehaw', 'password':'a'*129})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD)

    def testAdd3(self):
        """User already exists"""
        self.makeRequest("/users/add", method='POST', data = {'user':'first', 'password':'first'})
        respData = self.makeRequest("/users/add", method='POST', data = {'user':'first', 'password':'first'})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_USER_EXISTS)

    def testAdd4(self):
        """Name is blank"""
        respData = self.makeRequest("/users/add", method='POST', data = {'user':' ', 'password':'first'})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAdd5(self):
        """Name is too long"""
        respData = self.makeRequest("/users/add", method='POST', data = {'user':'G'*129, 'password':'first'})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)


class TestLoginUser(Tester):
    """Test User Login"""

    def testLogin1(self):
        """Successful Login twice, count is 2"""
        self.makeRequest("/users/add", method='POST', data = {'user':'first', 'password':'first'})
        respData = self.makeRequest("/users/login", method='POST', data = {'user':'first', 'password':'first'})
        self.assertResponse(respData, count = 2)

    def testLogin2(self):
        """User not found in the database"""
        self.makeRequest("/users/add", method='POST', data = {'user':'first', 'password':'first'})
        respData = self.makeRequest("/users/login", method='POST', data = {'user':'second', 'password':'first'})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)

    def testLogin3(self):
        """Password is incorrect"""
        self.makeRequest("/users/add", method='POST', data = {'user':'first', 'password':'first'})
        respData = self.makeRequest("/users/login", method='POST', data = {'user':'first', 'password':'second'})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)
