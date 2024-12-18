import Axios, { type AxiosInstance } from "axios";
import { ApiResponse, type IApiClient } from "@/@core";
import { AxiosError } from "./axios-error";

export const AxiosApiClient = (baseUrl: string): IApiClient => {
  const axios: AxiosInstance = Axios.create({
    baseURL: baseUrl,
    headers: {
      "Content-Type": "application/json",
    },
  });

  return {
    async get<Response>(endpoint: string, params?: Record<string, any>) {
      try {
        const response = await axios.get(endpoint, { params });
        return new ApiResponse<Response>({
          body: response.data,
          statusCode: response.status,
        });
      } catch (error) {
        return AxiosError<Response>(error);
      }
    },

    async post<Response>(endpoint: string, body: unknown) {
      try {
        const response = await axios.post(endpoint, body);
        return new ApiResponse<Response>({
          body: response.data,
          statusCode: response.status,
        });
      } catch (error) {
        return AxiosError<Response>(error);
      }
    },

    async put<Response>(endpoint: string, body: unknown) {
      try {
        const response = await axios.put(endpoint, body);
        return new ApiResponse<Response>({
          body: response.data,
          statusCode: response.status,
        });
      } catch (error) {
        return AxiosError<Response>(error);
      }
    },

    async delete<Response>(endpoint: string) {
      try {
        const response = await axios.delete(endpoint);
        return new ApiResponse<Response>({
          body: response.data,
          statusCode: response.status,
        });
      } catch (error) {
        return AxiosError<Response>(error);
      }
    },

    setHeader(key: string, value: string) {
      axios.defaults.headers[key] = value;
    },
    setAuthToken(token: string) {
      this.setHeader("Authorization", `Bearer ${token}`);
    },
  };
};

