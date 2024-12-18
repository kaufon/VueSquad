import type { SquadDto, UserDto } from "../dtos";
import type { ApiResponse } from "../responses";

export interface IDashBoardService {
	getUser(): Promise<ApiResponse<UserDto>>;
	getSquads(userId?: string): Promise<ApiResponse<SquadDto[]>>;
}
