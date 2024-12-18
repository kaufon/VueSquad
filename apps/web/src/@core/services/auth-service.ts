import type { ApiResponse } from "../responses/api-response";
import type { CreateUserDto } from "../dtos";

export interface IAuthService {
  login(email: string, password: string): Promise<ApiResponse<{ jwt: string }>>;
  logout(): Promise<unknown>;
  register(userDto: CreateUserDto): Promise<ApiResponse<unknown>>;
}
