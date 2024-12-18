import type { ApiResponse } from "../responses/api-response";

export interface IApiClient {
  setAuthToken(token:string): void,
  get<Response>(endpoint: string, params?: Record<string, any>): Promise<ApiResponse<Response>>;
  post<Response>(endpoint: string, body?: unknown): Promise<ApiResponse<Response>>;
  put<Response>(endpoint: string, body?: unknown): Promise<ApiResponse<Response>>;
  delete<Response>(endpoint: string): Promise<ApiResponse<Response>>;
  setHeader(key: string, value: string): void;
}

