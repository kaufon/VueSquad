import axios from "axios";
const API_URL = "http://localhost:3333";
const securedAxiosInstance = axios.create({
	baseURL: API_URL,
	withCredentials: true,
	headers: {
		"Content-Type": "application/json",
	},
});
const plainAxiosInstance = axios.create({
	baseURL: API_URL,
	withCredentials: true,
	headers: {
		"Content-Type": "application/json",
	},
});
securedAxiosInstance.interceptors.request.use((config) => {
	const method = config.method?.toUpperCase();
	if (method !== "OPTIONS" && method !== "GET") {
		const token = localStorage.getItem("jwt");
		if (token) {
			config.headers.Authorization = `Bearer ${token}`;
		}
	}
	return config;
});
securedAxiosInstance.interceptors.response.use(
	(response) => response,
	(error) => {
		if (error.response && error.response.status === 401) {
			localStorage.removeItem("jwt");

			window.location.href = "/login";

			return Promise.reject(error);
		}

		return Promise.reject(error);
	},
);
export { securedAxiosInstance, plainAxiosInstance };
