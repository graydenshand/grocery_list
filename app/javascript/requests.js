const axios = require("axios");
const baseUrl = "/api/v1";

export const fetchLists = function() {
  return axios.get(baseUrl + "/item_lists.json");
}

export const fetchList = function(item_list_id) {
  return axios.get(`${baseUrl}/item_lists/${item_list_id}.json`)
}

export const renameList = function(item_list_id, name) {
  return axios.put(`${baseUrl}/item_lists/${item_list_id}.json`, {
    name,
    authenticity_token: window._token
  })
}

export const deleteList = function(item_list_id) {
  return axios.delete(`${baseUrl}/item_lists/${item_list_id}.json`, {
    data: {authenticity_token: window._token}
  })
}

export const createList = function() {
  return axios.post(`${baseUrl}/item_lists.json`, {
    name: "Untitled",
    authenticity_token: window._token,
  })
}

export const renameItem = function(item_id, name) {
  return axios.put(`${baseUrl}/items/${item_id}.json`, {
    name,
    authenticity_token: window._token,
  })
}

export const deleteItem = function(item_id) {
  return axios.delete(`${baseUrl}/items/${item_id}.json`, {
    data: {authenticity_token: window._token}
  })
}

export const createItem = function(item_list_id) {
  return axios.post(`${baseUrl}/items.json`, {
    item_list_id: item_list_id,
    authenticity_token: window._token,
  })
}