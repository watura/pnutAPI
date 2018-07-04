import Foundation
import PnutAPI

public class StreamViewModel {
    private var meta: Meta?
    private var data: [PostResponse]?

    public init() {}
}

extension StreamViewModel: StreamDataSource {
    public func dataForUpdate(newer: Bool, updateValue: @escaping (TableUpdateData<PostResponse>) -> Void) {
        guard let maxId = meta?.maxId, let minId = meta?.minId else { return }
        let request: PostStreamsRequest
        if newer {
            request = PostStreamsRequest(sinceId: maxId)
        } else {
            request = PostStreamsRequest(beforeId: minId)
        }

        request.request(success: {[weak self] response in
            if let data = self?.data, !response.data.isEmpty {
                let value: TableUpdateData<PostResponse>
                var newData: [PostResponse]
                let list: [Int]

                if newer {
                    newData = response.data
                    newData.append(contentsOf: data)
                    list = (0...response.data.count - 1).map {return $0 }
                } else {
                    newData = data
                    newData.append(contentsOf: response.data)
                    list = (0...response.data.count - 1).map {return $0 + (self?.data?.count ?? 0) }
                }

                self?.data = newData
                value = TableUpdateData<PostResponse>(data: newData, insert: list)
                self?.meta = response.meta
                updateValue(value)
            } else {
                if let data = self?.data {
                    let value = TableUpdateData<PostResponse>(data: data)
                    updateValue(value)
                }
            }
            }, failure: {
                print($0)
        })
    }

    public func dataForReloadData(updateValue: @escaping ([PostResponse]) -> Void) {
        PostStreamsRequest().request(success: { [weak self] response in
            self?.meta = response.meta
            self?.data = response.data
            updateValue(response.data)
            }, failure: {
                print($0)
        })
    }
}
