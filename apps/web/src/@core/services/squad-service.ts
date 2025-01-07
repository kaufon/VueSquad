import type { SquadDto } from "../dtos";
import type { ApiResponse } from "../responses";

export interface ISquadService {
	register(name: string): Promise<ApiResponse<unknown>>;
	findById(id: string): Promise<ApiResponse<SquadDto>>;
}
