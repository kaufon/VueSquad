import { AxiosError as AxiosErrorType } from "axios";
import { ApiResponse } from "@/@core";

export function AxiosError<T>(error: unknown): ApiResponse<T> {
  if (error instanceof AxiosErrorType) {
    const errorMessage = error.message || "An error occurred";
    const statusCode = error.response?.status ?? 500; 
    const data = error.response?.data ?? {}; 

    console.error(`API Error: ${errorMessage}`);

    return new ApiResponse<T>({
      errorMessage,
      statusCode,
      body: data, 
    });
  }

  
  console.error("Unknown API Error:", error);

  return new ApiResponse<T>({
    errorMessage: "Unknown API error",
    statusCode: 500,
    body: {} as T,
  });
}

