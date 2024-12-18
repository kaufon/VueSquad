import type { IApiClient, IDashBoardService } from "@/@core";

export const DashBoardService = (apiClient: IApiClient): IDashBoardService => {
	return {
		async getUser() {
			return await apiClient.get("/users/");
		},
		async getSquads() {
			return await apiClient.get("/squads");
		},
	};
};
