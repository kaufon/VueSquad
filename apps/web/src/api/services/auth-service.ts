import type { IApiClient, IAuthService, CreateUserDto } from "@core";

export const AuthService = (apiClient: IApiClient): IAuthService => {
	return {
		async login(email: string, password: string) {
			return await apiClient.post("/auth/login", { email, password });
		},
		async logout() {
			return await apiClient.post("/auth/logout");
		},
		async register(userDto: CreateUserDto) {
			console.log(userDto);
			return await apiClient.post("/users", userDto);
		},
	};
};
