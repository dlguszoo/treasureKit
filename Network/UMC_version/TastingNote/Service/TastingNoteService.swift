// Copyright © 2024 DRINKIG. All rights reserved

import Foundation
import Moya

public final class TastingNoteService: NetworkManager {
    typealias Endpoint = TastingNoteEndpoint
    
    let provider : MoyaProvider<TastingNoteEndpoint>
    
    public init(provider: MoyaProvider<TastingNoteEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            CookiePlugin(),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<TastingNoteEndpoint>(plugins: plugins)
    }
    
    //MARK: - DTO funcs
    /// 새 노트 작성을 위한 DTO 생성 함수
    /// 모든 항목이 required임
    public func makePostNoteDTO(wineId : Int,
                         color: String,
                         tasteDate : String,
                         sugarContent: Int,
                         acidity : Int,
                         tannin : Int,
                         body : Int,
                         alcohol : Int,
                         nose : [String],
                         rating : Double,
                         review : String
    ) -> TastingNoteRequestDTO {
        return TastingNoteRequestDTO(wineId: wineId, color: color, tasteDate: tasteDate, sugarContent: sugarContent, acidity: acidity, tannin: tannin, body: body, alcohol: alcohol, nose: nose, rating: rating, review: review)
    }
    
    /// 노트 수정을 위한 DTO 생성 함수
    /// 모든 항목이 required임
    public func makeUpdateNoteDTO(noteId : Int,
                           body : TastingNoteUpdateRequestDTO) -> TastingNotePatchRequestDTO {
        return TastingNotePatchRequestDTO(noteId: noteId, body: body)
    }
    
    /// 노트 수정DTO의 body을 위한 DTO 생성 함수
    /// 모든 항목이 optional임
    public func makeUpdateNoteBodyDTO(color : String?,
                           tastingDate : String?,
                           sugarContent : Int?,
                           acidity : Int?,
                           tannin : Int?,
                           body : Int?,
                           alcohol : Int?,
                           addNoseList : [String]?,
                           removeNoseList : [Int]?,
                           satisfaction : Double?,
                           review : String?
    ) -> TastingNoteUpdateRequestDTO {
        return TastingNoteUpdateRequestDTO(color: color, tastingDate: tastingDate, sugarContent: sugarContent, acidity: acidity, tannin: tannin, body: body, alcohol: alcohol, addNoseList: addNoseList, removeNoseList: removeNoseList, rating: satisfaction, review: review)
    }
    
    //MARK: - API funcs
    
    /// 새 노트 작성 API
    public func postNote(data: TastingNoteRequestDTO, completion: @escaping (Result<String, NetworkError>) -> Void) {
        request(target: .postNote(data: data), decodingType: String.self, completion: completion)
    }
    
    /// 노트 수정 API
    public func patchNote(data: TastingNotePatchRequestDTO, completion: @escaping (Result<String, NetworkError>) -> Void) {
        request(target: .patchNote(data: data), decodingType: String.self, completion: completion)
    }
    
    /// 노트 삭제 API
    public func deleteNote(noteId: Int, completion: @escaping (Result<String, NetworkError>) -> Void) {
        request(target: .deleteNote(noteId: noteId), decodingType: String.self, completion: completion)
    }
    
    /// 특정 노트 정보 조회 API
    public func fetchNote(noteId: Int, completion: @escaping (Result<TastingNoteResponsesDTO, NetworkError>) -> Void) {
        request(target: .getNote(noteId: noteId), decodingType: TastingNoteResponsesDTO.self, completion: completion)
    }
    
    /// 모든 노트 정보 조회 API
    public func fetchAllNotes(sort: String, completion: @escaping (Result<AllTastingNoteResponseDTO?, NetworkError>) -> Void) {
        requestOptional(target: .getAllNotes(sort: sort), decodingType: AllTastingNoteResponseDTO.self, completion: completion)
    }
    
}
