import { AxiosApiClient } from "@/api/axios";
import { AuthService } from "@/api/services/auth-service";
import { DashBoardService } from "@/api/services/dashboard-service";

const axiosApiClient = AxiosApiClient("http://localhost:3333");
export function useApi() {
	if (localStorage.getItem("jwt")) {
		axiosApiClient.setAuthToken(localStorage.getItem("jwt") || " ");
	}
	return {
		authService: AuthService(axiosApiClient),
		dashboardService: DashBoardService(axiosApiClient),
	};
}
