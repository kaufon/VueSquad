import type { IApiClient, ISquadService } from "@/@core";

export const SquadService = (apiClient: IApiClient): ISquadService => {
	return {
		async register(name: string) {
			return await apiClient.post("/squads", { name });
		},
		async findById(id: string) {
			return await apiClient.get(`/squads/${id}`);
		},
	};
};
